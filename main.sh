#!/bin/bash

function prune() {
  # Check whether current directory is a git repository
  ghprune_isRepo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"

  if [[ -z $1 ]] # Handle empty command
  then
    if [[ $ghprune_isRepo ]]
    then
      echo "\n\tERROR: No command received."
      echo "\n\tusage: $0 [-i, -h, -s, -a, -r, -u, login, logout]"
      echo "\n\tFor a list of commands and their uses, type \`prune --help\`\n"
    else
      echo "\n\tERROR: This directory is not a git repository. Please navigate to a git repository in order to use prune locally\n"
    fi
  elif [[ $1 = "login" ]] || [[ $1 = "logout" ]] # Handle Github client authentication commands
  then
    if [[ $1 = "login" ]]
    then
      ghprune_handleLogin
    elif [[ $1 = "logout" ]]
    then
      ghprune_handleLogout
    fi
  else # Handle unauthenticated commands
    if [[ $ghprune_isRepo ]]
    then
      # Argument variables for local user
      argsEnv=local
      ghprune_interactiveFlag=off
      ghprune_hardFlag=off
      ghprune_softFlag=off
      ghprune_allFlag=off
      ghprune_remoteFlag=off

      # Determine whether to handle arguments for local user
      ghprune_willHandleLocalArgs=0

      while [ $# -gt 0 ]
      do
        case "$1" in
          -i) ghprune_interactiveFlag=on; ghprune_willHandleLocalArgs=1;;
          -h) ghprune_hardFlag=on; ghprune_willHandleLocalArgs=1;;
          -s) ghprune_softFlag=on; ghprune_willHandleLocalArgs=1;;
          -a) ghprune_allFlag=on; ghprune_willHandleLocalArgs=1;;
          -r) ghprune_remoteFlag=on; ghprune_willHandleLocalArgs=1;;
          -u) ghprune_handleUser "$@"; ghprune_willHandleLocalArgs=0; break;;
          --) shift; break;;
          -*) echo >&2 "\n\tusage: $0 [-i, -h, -s, -a, -r, -u, login, logout]\n"
              break;;
          *)  break;;
        esac
        shift
      done

      if [[ $ghprune_willHandleLocalArgs -gt 0 ]]
      then
        ghprune_handleArgs "$argsEnv" "$ghprune_interactiveFlag" "$ghprune_hardFlag" "$ghprune_softFlag" "$ghprune_allFlag" "$ghprune_remoteFlag"
      fi
    else
      echo "\n\tERROR: This directory is not a git repository. Please navigate to a git repository in order to use prune locally\n"
    fi
  fi
}

function ghprune_handleArgs() {
  # Under construction ---> localprune.sh?
  echo "$@"
}

function ghprune_handleUser() {
  # Argument variables
  ghprune_currentRepo=

  while [ $# -gt 0 ]
  do
    case "$2" in
      -R) ghprune_currentRepo="$3"; shift;;
      show) echo "\n\tCurrently logged in as: '$GHPRUNE_GITHUB_USER_NAME'\n";;
      --) shift; break;;
      -*) echo >&2 "\n\tusage: prune $1 [-R <repository>, show]\n"
          break;;
      *)  break;;
    esac
    shift
  done
}

function ghprune_handleLogin() {
  source ./auth.sh
  ghprune_userLogin
}

function ghprune_handleLogout() {
  source ./auth.sh
  ghprune_userLogout
}