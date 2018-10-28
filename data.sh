#!/bin/bash

function listUserRepos() {
  curl --silent -H "Authorization: token $GITHUB_USER_TOKEN" https://api.github.com/user/repos | jq 'reduce path(.[]?[]?[]?) as $path (.; setpath($path; null)) | ..|.name? | select(. != null)'
}

function fetchRemoteBranches() {
  curl --silent -H "Authorization: token $GITHUB_USER_TOKEN" https://api.github.com/repos/$GITHUB_USER_NAME/$1/branches
}