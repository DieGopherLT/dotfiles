#!/bin/bash

function pushale() {
  LocalBranch=$1

  if [[ -z "$LocalBranch" ]]; then
    git push
  else
    git push -u origin "$LocalBranch"
  fi
}

function pulele() {
  LocalBranch=$1

  if [[ -z "$LocalBranch" ]]; then
    git pull
  else
    git pull -u origin "$LocalBranch"
  fi
}

function commit() {
  if [[ "$1" == "-a" ]]; then
    git commit -a
  else
    git commit
  fi
}

function newbranch() {
  if [[ -z "$1" ]]; then
    echo "Usage: branch <branch_name>"
    return 1
  fi

  git checkout -b "$1"
}

function git_config_taloon {
  git config --global user.name "Diego López torres"
  git config --global user.email "diego.lpz.trrs.dev@gmail.com"
}