
# check installed
peco --version > /dev/null 2>&1
if [[ $? == 0 ]]; then
  export PECO_ENABLE=1
fi

systemctl --version > /dev/null 2>&1
if [[ $? == 0 ]]; then
  export SYSTEMCTL_ENABLE=1
fi

brew --version > /dev/null 2>&1
if [[ $? == 0 ]]; then
  export BREW_ENABLE=1
fi

go version > /dev/null 2>&1
if [[ $? == 0 ]]; then
  export GO_ENABLE=1
fi
