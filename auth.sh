#!/bin/bash

function login() {
  echo -n "To login, enter your GitHub username: "

  read githubUsername

  githubOAuthLogin=$(curl --silent -X PUT "https://api.github.com/authorizations/clients/$CLIENT_ID" \
    -u "$githubUsername" \
    -H "Content-Type: application/json" \
    -d '{
          "client_secret": "'"$CLIENT_SECRET"'",
          "scopes": [
            "repo"
          ],
          "note": "prune oAuth for repo scope"
        }')

  userToken=$(echo $githubOAuthLogin | jq '.token')
  userHashToken=$(echo $githubOAuthLogin | jq '.hashed_token')

  resetSessionData
  exportUserName "$githubUsername"
  exportUserHashToken "$userHashToken"

  if [[ $#userToken -gt 2 ]]
  then
    exportUserToken "$userToken"
  fi
  
  source ./.token.sh
  source ./.session.sh
}

function exportUserName() {
  echo "export GITHUB_USER_NAME=\"$1\"" >> .session.sh
}

function exportUserHashToken() {
  echo "export GITHUB_USER_HASH_TOKEN=$1" >> .session.sh
}

function resetSessionData() {
  echo "#!/bin/bash\n" > .session.sh
  source ./.session.sh
  unset GITHUB_USER_NAME
  unset GITHUB_USER_HASH_TOKEN
}

function exportUserToken() {
  echo "#!/bin/bash\n\nexport GITHUB_USER_TOKEN=$1" > .token.sh
}

function userLogout() {
  resetSessionData
  unset GITHUB_USER_TOKEN
}