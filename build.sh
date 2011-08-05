#!/bin/bash

set -e -u

name=synthbox
iso_label="ARCH_$(date +%Y%m)"
version=$(date +%Y.%m.%d)
install_dir=arch
arch=$(uname -m)
work_dir=work
verbose="n"

# Base installation (root-image)
make_basefs() {
    mkarchiso ${verbose} -D "${install_dir}" -p "base" create "${work_dir}"
    mkarchiso ${verbose} -D "${install_dir}" -p "memtest86+ syslinux mkinitcpio-nfs-utils nbd" create "${work_dir}"
}

# Additional packages (root-image)
make_packages() {
    mkarchiso ${verbose} -D "${install_dir}" -p "$(grep -v ^# packages.list)" create "${work_dir}"
}

# Customize installation (root-image)
make_customize_root_image() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        cp -af root-image ${work_dir}
        chmod 750 ${work_dir}/root-image/etc/sudoers.d
        chmod 440 ${work_dir}/root-image/etc/sudoers.d/g_wheel
        mkdir -p ${work_dir}/root-image/etc/pacman.d
        wget -O ${work_dir}/root-image/etc/pacman.d/mirrorlist http://www.archlinux.org/mirrorlist/all/
        sed -i "s/#Server/Server/g" ${work_dir}/root-image/etc/pacman.d/mirrorlist
        chroot ${work_dir}/root-image /usr/sbin/locale-gen
        chroot ${work_dir}/root-image /usr/sbin/useradd -m -p "" -g users -G "audio,disk,optical,wheel" arch
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Copy mkinitcpio archiso hooks (root-image)
make_setup_mkinitcpio() {
   if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        local _hook
        for _hook in archiso archiso_pxe_nbd archiso_loop_mnt; do
            cp /lib/initcpio/hooks/${_hook} ${work_dir}/root-image/lib/initcpio/hooks
            cp /lib/initcpio/install/${_hook} ${work_dir}/root-image/lib/initcpio/install
        done
        : > ${work_dir}/build.${FUNCNAME}
   fi
}

# Prepare ${install_dir}/boot/
make_boot() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        local _src=${work_dir}/root-image
        local _dst_boot=${work_dir}/iso/${install_dir}/boot
        mkdir -p ${_dst_boot}/${arch}
        mkinitcpio \
            -c ./mkinitcpio.conf \
            -b ${_src} \
            -k /boot/vmlinuz26 \
            -g ${_dst_boot}/${arch}/archiso.img
        mv ${_src}/boot/vmlinuz26 ${_dst_boot}/${arch}
        cp ${_src}/boot/memtest86+/memtest.bin ${_dst_boot}/memtest
        cp ${_src}/usr/share/licenses/common/GPL2/license.txt ${_dst_boot}/memtest.COPYING
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Prepare /${install_dir}/boot/syslinux
make_syslinux() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        local _src_syslinux=${work_dir}/root-image/usr/lib/syslinux
        local _dst_syslinux=${work_dir}/iso/${install_dir}/boot/syslinux
        mkdir -p ${_dst_syslinux}
        sed "s|%ARCHISO_LABEL%|${iso_label}|g;
            s|%INSTALL_DIR%|${install_dir}|g;
            s|%ARCH%|${arch}|g" syslinux/syslinux.cfg > ${_dst_syslinux}/syslinux.cfg
        cp syslinux/splash.png ${_dst_syslinux}
        cp ${_src_syslinux}/*.c32 ${_dst_syslinux}
        cp ${_src_syslinux}/*.com ${_dst_syslinux}
        cp ${_src_syslinux}/*.0 ${_dst_syslinux}
        cp ${_src_syslinux}/memdisk ${_dst_syslinux}
        mkdir -p ${_dst_syslinux}/hdt
        wget -O - http://pciids.sourceforge.net/v2.2/pci.ids | gzip -9 > ${_dst_syslinux}/hdt/pciids.gz
        cat ${work_dir}/root-image/lib/modules/*-ARCH/modules.alias | gzip -9 > ${_dst_syslinux}/hdt/modalias.gz
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Prepare /isolinux
make_isolinux() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        mkdir -p ${work_dir}/iso/isolinux
        sed "s|%INSTALL_DIR%|${install_dir}|g" isolinux/isolinux.cfg > ${work_dir}/iso/isolinux/isolinux.cfg
        cp ${work_dir}/root-image/usr/lib/syslinux/isolinux.bin ${work_dir}/iso/isolinux/
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Split out /lib/modules from root-image (makes more "dual-iso" friendly)
make_lib_modules() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        mv ${work_dir}/root-image/lib/modules ${work_dir}/lib-modules
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Split out /usr/share from root-image (makes more "dual-iso" friendly)
make_usr_share() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        mv ${work_dir}/root-image/usr/share ${work_dir}/usr-share
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Make [core] repository, keep "any" pkgs in a separate fs (makes more "dual-iso" friendly)
make_core_repo() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        local _url _urls _pkg_name _cached_pkg _dst
        mkdir -p ${work_dir}/core-any-pkgs
        mkdir -p ${work_dir}/core-pkgs
        pacman -Sy
        _urls=$(pacman -Sddp $(comm -2 -3 <(pacman -Sql core | sort ) <(grep -v ^# core.exclude.${arch} | sort)))
        for _url in ${_urls}; do
            _pkg_name=${_url##*/}
            _cached_pkg=/var/cache/pacman/pkg/${_pkg_name}
            _dst=${work_dir}/core-pkgs/${_pkg_name}
            if [[ ! -e ${_dst} ]]; then
                if [[ -e ${_cached_pkg} ]]; then
                    cp -v "${_cached_pkg}" "${_dst}"
                else
                    wget -nv "${_url}" -O "${_dst}"
                fi
            fi
            repo-add -q ${work_dir}/core-pkgs/core.db.tar.gz ${work_dir}/core-pkgs/${_pkg_name}
            if [[ ${_pkg_name} =~ any.pkg ]]; then
                mv "${_dst}" ${work_dir}/core-any-pkgs/${_pkg_name}
                ln -sf ../any/${_pkg_name} ${work_dir}/core-pkgs/${_pkg_name}
            fi
        done
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Process aitab
# args: $1 (core | netinstall)
make_aitab() {
    local _iso_type=${1}
    if [[ ! -e ${work_dir}/build.${FUNCNAME}_${_iso_type} ]]; then
        sed "s|%ARCH%|${arch}|g" aitab.${_iso_type} > ${work_dir}/iso/${install_dir}/aitab
        : > ${work_dir}/build.${FUNCNAME}_${_iso_type}
    fi
}

# Build all filesystem images specified in aitab (.fs .fs.sfs .sfs)
make_prepare() {
    mkarchiso ${verbose} -D "${install_dir}" prepare "${work_dir}"
}

# Build ISO
# args: $1 (core | netinstall)
make_iso() {
    local _iso_type=${1}
    mkarchiso ${verbose} -D "${install_dir}" -L "${iso_label}" iso "${work_dir}" "${name}-${version}-${_iso_type}-${arch}.iso"
}

# Build dual-iso images from ${work_dir}/i686/iso and ${work_dir}/x86_64/iso
# args: $1 (core | netinstall)
make_dual() {
    local _iso_type=${1}
    if [[ ! -e ${work_dir}/dual/build.${FUNCNAME}_${_iso_type} ]]; then
        if [[ ! -d ${work_dir}/i686/iso || ! -d ${work_dir}/x86_64/iso ]]; then
            echo "ERROR: i686 or x86_64 builds does not exist."
            _usage 1
        fi
        local _src_one _src_two _cfg
        if [[ ${arch} == "i686" ]]; then
            _src_one=${work_dir}/i686/iso
            _src_two=${work_dir}/x86_64/iso
        else
            _src_one=${work_dir}/x86_64/iso
            _src_two=${work_dir}/i686/iso
        fi
        mkdir -p ${work_dir}/dual/iso
        cp -a -l -f ${_src_one} ${work_dir}/dual
        cp -a -l -n ${_src_two} ${work_dir}/dual
        rm -f ${work_dir}/dual/iso/${install_dir}/aitab
        rm -f ${work_dir}/dual/iso/${install_dir}/boot/syslinux/syslinux.cfg
        if [[ ${_iso_type} == "core" ]]; then
            if [[ ! -e ${work_dir}/dual/iso/${install_dir}/any/core-any-pkgs.sfs ||
                  ! -e ${work_dir}/dual/iso/${install_dir}/i686/core-pkgs.sfs ||
                  ! -e ${work_dir}/dual/iso/${install_dir}/x86_64/core-pkgs.sfs ]]; then
                    echo "ERROR: core_iso_single build is not found."
                    _usage 1
            fi
        else
            rm -f ${work_dir}/dual/iso/${install_dir}/any/core-any-pkgs.sfs
            rm -f ${work_dir}/dual/iso/${install_dir}/i686/core-pkgs.sfs
            rm -f ${work_dir}/dual/iso/${install_dir}/x86_64/core-pkgs.sfs
        fi
        paste -d"\n" <(sed "s|%ARCH%|i686|g" aitab.${_iso_type}) \
                     <(sed "s|%ARCH%|x86_64|g" aitab.${_iso_type}) | uniq > ${work_dir}/dual/iso/${install_dir}/aitab
        for _cfg in syslinux.dual/*.cfg; do
            sed "s|%ARCHISO_LABEL%|${iso_label}|g;
                 s|%INSTALL_DIR%|${install_dir}|g" ${_cfg} > ${work_dir}/dual/iso/${install_dir}/boot/syslinux/${_cfg##*/}
        done
        mkarchiso ${verbose} -D "${install_dir}" -L "${iso_label}" iso "${work_dir}/dual" "${name}-${version}-${_iso_type}-dual.iso"
        : > ${work_dir}/dual/build.${FUNCNAME}_${_iso_type}
    fi
}



_usage ()
{
    echo "usage ${0##*/} net_iso_single | core_iso_single | all_iso_single | clean_single"
    echo "               net_iso_dual   | core_iso_dual   | all_iso_dual   | clean_dual"
    echo
    exit ${1}
}

if [[ ${EUID} -ne 0 ]]; then
    echo "This script must be run as root."
    _usage 1
fi

if [[ $# -lt 1 ]]; then
    echo "No command specified"
    _usage 1
fi
command_name="${1}"

if [[ ${verbose} == "y" ]]; then
    verbose="-v"
else
    verbose=""
fi

if [[ ${command_name} =~ single ]]; then
    work_dir=${work_dir}/${arch}
fi

make_common_single() {
    make_basefs
    make_packages
    make_customize_root_image
    make_setup_mkinitcpio
    make_boot
    make_syslinux
    make_isolinux
    make_lib_modules
    make_usr_share
    make_aitab $1
    make_prepare $1
    make_iso $1
}

case "${command_name}" in
    net_iso_single)
        make_common_single netinstall
        ;;
    core_iso_single)
        make_core_repo
        make_common_single core
        ;;
    all_iso_single)
        make_common_single netinstall
        make_core_repo
        make_common_single core
        ;;
    net_iso_dual)
        make_dual netinstall
        ;;
    core_iso_dual)
        make_dual core
        ;;
    all_iso_dual)
        make_dual netinstall
        make_dual core
        ;;
    clean_single)
        rm -rf ${work_dir}
        rm -f ${name}-${version}-*-${arch}.iso
        ;;
    clean_dual)
        rm -rf ${work_dir}/dual
        rm -f ${name}-${version}-*-dual.iso
        ;;
    *)
        echo "Invalid command name '${command_name}'"
        _usage 1
        ;;
esac
