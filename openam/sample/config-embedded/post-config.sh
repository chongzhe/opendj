#!/usr/bin/env bash
# This is an example of using curl against the REST API
# This will get replaced by the next gen ssoadm command in AM 14

source env.sh


openam="${SERVER_URL}/openam"


# Nice little script courtesy of Andy Hall to get the SSO token
ssoToken=$(curl -s -X POST -H "Content-Type: application/json" -H "X-OpenAM-Username: amadmin" \
   -H "X-OpenAM-Password: ${ADMIN_PWD}" -d '{}' "${openam}/json/authenticate")

firstCut=${ssoToken#*:}
secondCut=${firstCut%,*}
length=${#secondCut}-2
finalCut=${secondCut:1:$length}
ssoToken=$finalCut


function post {
   echo "post: $2"
   echo "data: $1"

  curl -s -X POST -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d "$1" "$2"
}


# Example of enabling OAuth2 / OIDC
post '{}' "${openam}/json/realm-config/services/oauth-oidc?_action=create&_prettyPrint=true"

# example of creating a realm
realm=testrealm

post '{"name":"'${realm}'","parentPath":"/","aliases":[],"active":true,"statelessSessionsEnabled":false}'  \
   "${openam}/json/global-config/realms?_action=create&_prettyPrint=true"


# Example of creating an OAuth2 client
client=oauthtest

post '{"username":"'${client}'", "AgentType": "OAuth2Client", "userpassword": "password", "com.forgerock.openam.oauth2provider.redirectionURIs": [], "com.forgerock.openam.oauth2provider.scopes": ["[0]=openid"], "com.forgerock.openam.oauth2provider.defaultScopes": [], "com.forgerock.openam.oauth2provider.tokenEndPointAuthMethod": "client_secret_post"}'  \
 "${openam}/json/agents?_action=create&_prettyPrint=true"


# Test OAuth2
# Not working - todo: find out why
#post 'grant_type=password&username=demo&password=changeit&client_id='${client}'&client_secret=password&scope=openid' \
#     "${openam}/oauth2/access_token"

