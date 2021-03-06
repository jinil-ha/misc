MISC_DIR=`dirname $0`

# auto update
if [ -z $DISABLE_AUTO_UPDATE ]; then
  env TARGET_DIR=$HOME/.misc zsh -f $HOME/.misc/update.sh
fi

# check package status & export environment variable
if [ -f $MISC_DIR/sh/check.sh ]; then
  source $MISC_DIR/sh/check.sh
fi

# variables
export PROMPT=$'%{$fg_bold[green]%}%n@%m%{$fg[blue]%}%D{[%H%M%S]}%{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%}$(git_prompt_info)%{$fg_bold[blue]%}%#%{$reset_color%} '
export EDITOR=vim
export SAVEHIST=100000
export HISTSIZE=100000
export HIST_STAMPS="yyyy-mm-dd"
export PATH=${PATH}:~/bin
export JAVA_HOME=/usr
export HOMEBREW_NO_ANALYTICS=1
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export GPG_TTY=$(tty)


# options
setopt auto_pushd
setopt no_share_history
setopt auto_cd
cdpath=(.. ~)
setopt print_exit_value
setopt correct
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
zstyle ':completion:*' menu select

# key-binding
bindkey "^B" backward-word
bindkey "^F" forward-word

# aliases
alias l='ls -lh'
alias ll='ls -lah'
alias sudo='sudo -E '
alias less='less -j15'
if [ -n "${SYSTEMCTL_ENABLE+1}" ]; then
  alias sc='systemctl'
elif [ -n "${BREW_ENABLE+1}" ]; then
  alias sc='brew services'
fi
if [ -n "${PECO_ENABLE+1}" ]; then
  alias hi='history -n | peco'
  alias pp='ps aux | peco --query="$1" | pbcopy'
else
  alias hi='history -n'
fi
alias reload_zsh='source ~/.zshrc'
alias https='http --default-scheme=https'

# config by OS
os=`uname 2> /dev/null`
case "$os" in
  Darwin)
    alias listen='lsof -iTCP -sTCP:LISTEN -nP'
    ;;
  Linux)
    alias listen='netstat -tlnp'
    alias ps='ps ux -H'
    alias psa='ps a'
    ;;
esac

# functions
if [ -n "${PECO_ENABLE+1}" ]; then
  gitcd() {
    local selected
    selected=`find ~/dev/src -mindepth 3 -maxdepth 3 -type d | peco --query="$1"`
    if [ -n "$selected" ]; then
      builtin cd $selected
    fi
  }
fi

# source .zshrc.local
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
