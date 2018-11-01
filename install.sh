#!/bin/bash

export pruneDir="$(cd -P "$(dirname "$0")" && pwd)"

if [[ "$pruneDir" != "$HOME/.gh_prune" ]]
then
  ln -fs $pruneDir $HOME/.gh_prune
fi

ghpruneExec="[ -s \"$HOME/.gh_prune/gh_prune.sh\" ] && source \"$HOME/.gh_prune/gh_prune.sh\" #KEEP_THIS_COMMENT-AddsPruneToShell"

nowInstalled=false
alreadyInProfile=false

for profile in bashrc zshrc bash_profile
do
  if [[ -s "$HOME/.$profile" ]]
  then
    if grep -q "$ghpruneExec" "$HOME/.$profile"
    then
      printf "\n\tPrune already exists in your $profile file.\n"
      alreadyInProfile=true
    else
      printf "$ghpruneExec" >> "$HOME/.$profile"
      printf "\n\tAdded prune to $HOME/.$profile\n"
      nowInstalled=true
    fi
  fi
done

if [[ $nowInstalled = true ]]
then
  printf "\n\tPrune installed successfully! 🎉\n"
  printf "\n\tTo use prune, open a new shell session and type \`prune [command]\`\n"
  printf "\n\tFor a list of commands, type \`prune --help\`\n\n"
elif [[ $alreadyInProfile = true ]]
then
  printf "\n\tTo use prune, type \`prune [command]\`\n"
  printf "\n\tFor a list of commands, type \`prune --help\`\n\n"
else
  printf "\n\tERROR: prune not added to shell profile.\n"
  printf "\n\tPlease check your profile and add the following line to install manually\n"
  printf "\n\t--> $ghpruneExec\n\n"
fi
