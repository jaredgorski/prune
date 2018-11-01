#!/bin/bash

ghpruneExec="[ -s \"$HOME/.gh_prune/gh_prune.sh\" ] && source \"$HOME/.gh_prune/gh_prune.sh\""

for profile in bashrc zshrc bash_profile
do
  if [[ -s "$HOME/.$profile" ]]
  then
    if grep -q "$ghpruneExec" "$HOME/.$profile"
    then
      awk '!/#KEEP_THIS_COMMENT-AddsPruneToShell/' "$HOME/.$profile" > .temprc && mv .temprc "$HOME/.$profile"
      rm -rf "$HOME/.gh_prune"
      unset ghpruneDir
      printf "\n\tPrune uninstalled successfully. Restart your shell.\n\n"
    else
      printf "\n\tPrune is not currently installed on your profile. Execute \`./install.sh\` if you would like to install.\n"
      printf "\n\tExecute \`./install.sh\` if you would like to install.\n\n"
    fi
  fi
done
