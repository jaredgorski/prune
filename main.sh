#!/bin/bash

source ./.env.sh
source ./auth.sh
source ./data.sh

function prune() {
  if [[ -v GITHUB_USER_NAME ]]
  then
    isRepo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    
    if [[ $1 ]]
    then
      handleArgs
    else
      if [[ $isRepo ]]
      then
        currentRepo=$(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p')
        userRepos=$(listUserRepos)

        if echo $userRepos | grep -w $currentRepo > /dev/null
        then
          fetchRemoteBranches "$currentRepo"
        else
          echo "Cannot resolve local repository with remote. Please verify that you own this remote repository: \"$currentRepo\""
        fi
      else
        echo "This folder is not a repository"
      fi
    fi
  else
    login
  fi
}

function handleArgs() {
  echo "argument: $1"
}