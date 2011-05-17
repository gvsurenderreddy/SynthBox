
#we want to be able to use these from scripts
alias ladish_control='python2 /usr/bin/ladish_control'

# Check for an interactive session
[ -z "$PS1" ] && return
export PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 26 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname`:`pwd`\007"'
export PATH=$PATH:/home/$USER/bin

#we don't want/need these to be useable in scripts
alias ls='ls --color=auto'
alias la='ls -la'
alias lp='la | less'
