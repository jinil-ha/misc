#!/usr/bin/env zsh

zmodload zsh/datetime

update_min_days=7
update_file=.update

function _epoch_days() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_epoch() {
  echo "LAST_UPDATE=$(_epoch_days)" >! $update_file
}

# check TARGER_DIR
[ -z TARGET_DIR ] && return 1
pushd $TARGET_DIR > /dev/null 2>&1

# check git available
whence git >/dev/null || return 1

# check last update
if [ ! -f $update_file ]; then
  _update_epoch
fi
source $update_file
if [[ -z "$LAST_UPDATE" ]]; then
  echo ERROR: not exist LAST_UPDATE
  _update_epoch
  return 1
fi

# update
days_after_update=$(($(_epoch_days) - $LAST_UPDATE))
if [ $days_after_update -gt $update_min_days ]; then
  git pull > /dev/null 2>&1
  echo misc version: `git rev-parse --short HEAD`
  _update_epoch
fi
