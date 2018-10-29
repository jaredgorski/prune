#!/bin/bash

function ghprune_fetchPrunableBranches() {
  sedVersion=$(sed --version | head -n 1)

  if [[ $sedVersion =~ "GNU" ]]
  then
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
  else
    echo "\n\tNOTICE: This functionality currently only works with \`gnu-sed\` installed. It is available via Homebrew with the command:"
    echo "\n\t\t$ brew install gnu-sed --default-names\n"
    echo "\tPlease be sure to include the \`--default-names\` flag, which allows \`gnu-sed\` to use the default \`sed\` command."
    echo -n "\n\tWould you like me to install it for you? [ Yy / Nn ]: "

    read ghprune_answer

    case ${ghprune_answer:0:1} in
      y|Y) brew install gnu-sed --default-names;;
      *)   echo "\n";;
    esac
  fi
}

function ghprune_fetchLocalBranches() {
  ghprune_fetchedLocalBranches=()

  IFS=$'\n'

  ghprune_localBranches_raw=( $(git branch) )

  for item in ${ghprune_localBranches_raw[@]}
  do
    ghprune_localBranchName_untrimmed=${item##*\]}
    ghprune_localBranchName=$(echo -e "${ghprune_localBranchName_untrimmed}" | tr -d '[:space:]' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    ghprune_fetchedLocalBranches+=($ghprune_localBranchName)
  done

  unset IFS

  echo ${ghprune_fetchedLocalBranches[@]}
}

function ghprune_fetchRemoteBranches() {
  ghprune_fetchedRemoteBranches=()

  IFS=$'\n'

  ghprune_remoteBranches_raw=( $(git branch -r) )

  for item in ${ghprune_remoteBranches_raw[@]}
  do
    if [ ! $item =~ "HEAD" ] && [ ! $item =~ "->" ]
    then
      ghprune_remoteBranchName_untrimmed=${item##*/}
      ghprune_remoteBranchName=$(echo -e "${ghprune_remoteBranchName_untrimmed}" | tr -d '[:space:]' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
      ghprune_fetchedRemoteBranches+=($ghprune_remoteBranchName)
    fi
  done

  unset IFS

  echo ${ghprune_fetchedRemoteBranches[@]}
}