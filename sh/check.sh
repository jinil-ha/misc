
# check installed
if type peco &> /dev/null; then 
  export PECO_ENABLE=1
fi

if type systemctl &> /dev/null; then
  export SYSTEMCTL_ENABLE=1
fi

if type brew &> /dev/null; then
  export BREW_ENABLE=1
fi

if type go &> /dev/null; then
  export GO_ENABLE=1
fi
