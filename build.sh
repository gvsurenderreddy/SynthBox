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
        chmod 440 ${work_dir}/root-image/etc/sudoers.d/g_admin
        #===Grabbing Pacman mirrors not necessary for SynthBox.
        #mkdir -p ${work_dir}/root-image/etc/pacman.d
        #wget -O ${work_dir}/root-image/etc/pacman.d/mirrorlist http://www.archlinux.org/mirrorlist/all/
        #sed -i "s/#Server/Server/g" ${work_dir}/root-image/etc/pacman.d/mirrorlist
        chroot ${work_dir}/root-image /usr/sbin/locale-gen
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

# Process aitab
make_aitab() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        sed "s|%ARCH%|${arch}|g" aitab > ${work_dir}/iso/${install_dir}/aitab
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Build all filesystem images specified in aitab (.fs .fs.sfs .sfs)
make_prepare() {
    mkarchiso ${verbose} -D "${install_dir}" prepare "${work_dir}"
}

# Build ISO
make_iso() {
    mkarchiso ${verbose} -D "${install_dir}" -L "${iso_label}" iso "${work_dir}" "${name}-${version}-${arch}.iso"
}

if [[ $verbose == "y" ]]; then
    verbose="-v"
else
    verbose=""
fi

make_basefs
make_packages
make_customize_root_image
make_setup_mkinitcpio
make_boot
make_syslinux
make_isolinux
make_aitab
make_prepare
make_iso
