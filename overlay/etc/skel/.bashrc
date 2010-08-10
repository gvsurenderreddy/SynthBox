
# Check for an interactive session
[ -z "$PS1" ] && return
export PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 26 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname`:`pwd`\007"'


alias ls='ls --color=auto'
alias la='ls -la'
alias lp='la | less'
alias jackBristol='startBristol -audio jack -midi jack -rate 48000 -count 512'

