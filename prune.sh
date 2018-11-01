#!/bin/bash

function ghprune_prunePrunableBranches_local() {
  source $HOME/.gh_prune/branches.sh

  ghprune_branchesToPrune=( $(ghprune_fetchPrunableBranches) )

  if [[ ${#ghprune_branchesToPrune[@]} -gt 0 ]]
  then
    currentBranchName=$(git rev-parse --abbrev-ref HEAD)

    if [[ $currentBranchName != "master" ]]
    then
      echo "\n\tLooks like you're not in the 'master' branch. I will not be able to prune this branch while you're on it, so you may see an error."
      echo "\n\tTo avoid this, switch to the 'master' branch."
      echo -n "\n\tWould you like to prune anyway? [ Yy / Nn ]: "

      read ghprune_answer

      case ${ghprune_answer:0:1} in
        y|Y) echo "\n"
             ghprune_executePrune_default;;
        *)   echo " ";;
      esac
    else
      ghprune_executePrune_default
    fi
  else
    currentRepoPath=$(git rev-parse --show-toplevel)
    currentRepoName=$(basename $currentRepoPath)

    echo "\n\tLocal branches on the '$currentRepoName' repository are currently pruned. 🎉\n"
    echo "\tRepository location: $currentRepoPath\n"
  fi
}

function ghprune_executePrune_default() {
  echo "\n\tPruning local branches relative to remote...\n"

  for branch in $ghprune_branchesToPrune
  do
    pruneVox=$(git branch -D "$branch" 2>&1)
    pruneVox_firstWord=$(echo "$pruneVox" | awk '{print $1;}')

    if [[ $pruneVox_firstWord =~ "error" ]]
    then
      echo "\t✖  $pruneVox"
    else
      echo "\t⌶  $pruneVox"
    fi
  done

  echo "\n\tComplete.\n"
}