
#we want to be able to use these from scripts
alias ladish_control='python2 /usr/bin/ladish_control'
alias a2j_control='python2 /usr/bin/a2j_control'

# Check for an interactive session
[ -z "$PS1" ] && return
export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
export PATH=$PATH:$HOME/bin

#we don't want/need these to be useable in scripts
alias ls='ls --color=auto'
alias la='ls -la'
alias lp='la | less'
