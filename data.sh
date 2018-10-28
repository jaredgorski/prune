#!/bin/bash

function ghprune_listUserRepos() {
  curl --silent -H "Authorization: token $GHPRUNE_GITHUB_USER_TOKEN" https://api.github.com/user/repos | jq 'reduce path(.[]?[]?[]?) as $path (.; setpath($path; null)) | ..|.name? | select(. != null)'
}

function ghprune_fetchRemoteBranches() {
  curl --silent -H "Authorization: token $GHPRUNE_GITHUB_USER_TOKEN" https://api.github.com/repos/$GHPRUNE_GITHUB_USER_NAME/$1/branches
}