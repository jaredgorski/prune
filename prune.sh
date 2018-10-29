#!/bin/bash

function ghprune_prunePrunableBranches_local() {
  source ./branches.sh

  ghprune_branchesToPrune=( $(ghprune_fetchPrunableBranches) )

  if [[ ${#ghprune_branchesToPrune[@]} -gt 0 ]]
  then
    echo "\n\tPruning local branches relative to remote...\n"

    for branch in $ghprune_branchesToPrune
    do
      pruneVox=$(git branch -D "$branch")
      echo "\t⌶  $pruneVox"
    done

    echo "\n\tPrune complete.\n"
  else
    currentRepoPath=$(git rev-parse --show-toplevel)
    currentRepoName=$(basename $currentRepoPath)

    echo "\n\tLocal branches on the '$currentRepoName' repository are currently pruned. 🎉\n"
    echo "\tRepository location: $currentRepoPath\n"
  fi
}