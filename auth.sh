#!/bin/bash

function ghprune_userLogin() {
  # Source necessary files
  source $HOME/.gh_prune/.env.sh
  if [[ -a ".session.sh" ]]
  then
    source $HOME/.gh_prune/.session.sh
  fi
  # source $HOME/.gh_prune/data.sh ---> to be moved to user document

  if [[ ! -v GHPRUNE_LOGGED_IN ]]
  then
    echo -n "\nPlease enter the Github username of the account you would like to access: "

    read ghprune_githubUsername

    ghprune_githubOAuthLogin=$(curl --silent -X PUT "https://api.github.com/authorizations/clients/$CLIENT_ID" \
      -u "$ghprune_githubUsername" \
      -H "Content-Type: application/json" \
      -d '{
            "client_secret": "'"$CLIENT_SECRET"'",
            "scopes": [
              "repo"
            ],
            "note": "prune oAuth for repo scope"
          }')

    ghprune_userToken=$(echo $ghprune_githubOAuthLogin | jq '.token')
    ghprune_userHashToken=$(echo $ghprune_githubOAuthLogin | jq '.hashed_token')

    ghprune_resetSessionData
    ghprune_setSession_userName "$ghprune_githubUsername"
    ghprune_setSession_userHashToken "$ghprune_userHashToken"

    if [[ $#ghprune_userToken -gt 2 ]]
    then
      ghprune_setUserToken "$ghprune_userToken"
    fi

    source $HOME/.gh_prune/.token.sh
    source $HOME/.gh_prune/.session.sh
    echo "GHPRUNE_LOGGED_IN=true" >> .session.sh
    echo "\nNow logged in as '$GHPRUNE_GITHUB_USER_NAME'."
  else
    echo "\n\tERROR: Already logged in as $GHPRUNE_GITHUB_USER_NAME."
    echo "\n\tPlease logout first using \`prune logout\` if you would like to log in as another user.\n"
  fi
}

function ghprune_setSession_userName() {
  echo "GHPRUNE_GITHUB_USER_NAME=\"$1\"" >> .session.sh
}

function ghprune_setSession_userHashToken() {
  echo "GHPRUNE_GITHUB_USER_HASH_TOKEN=$1" >> .session.sh
}

function ghprune_resetSessionData() {
  echo "#!/bin/bash\n" > .session.sh
  source $HOME/.gh_prune/.session.sh
  unset GHPRUNE_GITHUB_USER_NAME
  unset GHPRUNE_GITHUB_USER_HASH_TOKEN
  unset GHPRUNE_LOGGED_IN
}

function ghprune_setUserToken() {
  echo "#!/bin/bash\n\nGHPRUNE_GITHUB_USER_TOKEN=$1" > .token.sh
}

function ghprune_userLogout() {
  if [[ -a ".session.sh" ]]
  then
    source $HOME/.gh_prune/.session.sh
  fi

  if [[ -v GHPRUNE_LOGGED_IN ]]
  then
    ghprune_resetSessionData
    rm .session.sh
    unset GHPRUNE_GITHUB_USER_TOKEN

    echo "\nLogged out successfully."
  else
    echo "\n\tLooks like you're not currently logged into the prune Github client."
    echo -n "\n\tWould you like to login? [ Yy / Nn ]: "

    read ghprune_answer

    case ${ghprune_answer:0:1} in
      y|Y) ghprune_userLogin;;
      *)   echo " ";;
    esac
  fi
}
