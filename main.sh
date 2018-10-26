#!/bin/bash

function prune() {
  isrepo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  branches="$(git branch)"
  if [ "$isrepo" ]
  then
    echo $branches
  else
    echo "not a repo"
  fi
}