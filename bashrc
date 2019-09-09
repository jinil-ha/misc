# alias
alias mkdir='mkdir -pv'
alias less='less -j15'
alias ll='ls -alG'
alias l='ls -lG'
alias psa='ps aux -H'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../..'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# functions
myip() { curl http://ieserver.net/ipcheck.shtml ; }
myps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }
listen() { netstat -an | grep LISTEN ; }
xcat() { cat $@ | grep -v -e ^.*# -e ^$ ; }
tounix() { tr -d '\r' < $1 ; }
mcd() { mkdir -p "$1" && cd "$1" ; }
trash() { command mv "$@" ~/.Trash ; }
gitcd() {
  local selected
  selected=`find ~/dev/src -mindepth 3 -maxdepth 3 -type d | peco --query="$1"`
  if [ -n "$selected" ]; then
    builtin cd $selected
  fi
}

# prompt
export PS1="[\[\033[0;32m\]\u\[\033[00m\]@\[\033[0;31m\]\h \[\033[0;33m\]\W\[\033[00m\]]\$ "
export PS2=">"

# variables
export BLOCKSIZE=1k
export HISTSIZE=10000
