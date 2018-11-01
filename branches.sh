#!/bin/bash

function ghprune_fetchPrunableBranches() {
  ghprune_localBranches=( $(ghprune_fetchLocalBranches) )
  ghprune_remoteBranches=( $(ghprune_fetchRemoteBranches) )

  ghprune_prunableBranches=()

  for localBranch in $ghprune_localBranches
  do
    ghprune_hasRemoteMatch=false

    for remoteBranch in $ghprune_remoteBranches
    do
      if [[ "$remoteBranch" = "$localBranch" ]]
      then
        ghprune_hasRemoteMatch=true
      fi
    done

    if [[ $ghprune_hasRemoteMatch = "false" ]]
    then
      ghprune_prunableBranches+=($localBranch)
    fi
  done

  echo ${ghprune_prunableBranches[@]}
}

function ghprune_fetchLocalBranches() {
  ghprune_fetchedLocalBranches=()

  IFS=$'\n'

  ghprune_localBranches_raw=( $(git branch --no-color) )

  for item in ${ghprune_localBranches_raw[@]}
  do
    ghprune_localBranchName_untrimmed=${item##*\]}
    ghprune_localBranchName=$(echo -e "${ghprune_localBranchName_untrimmed}" | tr -d '[:space:]')
    ghprune_fetchedLocalBranches+=($ghprune_localBranchName)
  done

  unset IFS

  echo ${ghprune_fetchedLocalBranches[@]}
}

function ghprune_fetchRemoteBranches() {
  ghprune_fetchedRemoteBranches=()

  IFS=$'\n'

  ghprune_remoteBranches_raw=( $(git branch -r --no-color) )

  for item in ${ghprune_remoteBranches_raw[@]}
  do
    if [ ! $item =~ "HEAD" ] && [ ! $item =~ "->" ]
    then
      ghprune_remoteBranchName_untrimmed=${item##*/}
      ghprune_remoteBranchName=$(echo -e "${ghprune_remoteBranchName_untrimmed}" | tr -d '[:space:]')
      ghprune_fetchedRemoteBranches+=($ghprune_remoteBranchName)
    fi
  done

  unset IFS

  echo ${ghprune_fetchedRemoteBranches[@]}
}