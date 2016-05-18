#!/usr/bin/env bash
# Test script to setup OIDC provider and client.

# openam="http://openam.localtest.me:8080/openam"
openam="https://test.my2do.com/openam"

ssoToken=$(curl -X POST -H "Content-Type: application/json" -H "X-OpenAM-Username: amadmin" -H "X-OpenAM-Password: password" -d '{}' "${openam}/json/authenticate")

firstCut=${ssoToken#*:}
secondCut=${firstCut%,*}
length=${#secondCut}-2
finalCut=${secondCut:1:$length}

ssoToken=$finalCut

client=oidctest2

curl -X POST -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d '{}' "${openam}/json/realm-config/services/oauth-oidc?_action=create&_prettyPrint=true"

curl -X POST -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d '{"username":"'${client}'", "AgentType": "OAuth2Client", "userpassword": "password", "com.forgerock.openam.oauth2provider.redirectionURIs": ["[0]=http://localhost/redirect_uri"], "com.forgerock.openam.oauth2provider.scopes": ["[0]=openid"], "com.forgerock.openam.oauth2provider.defaultScopes": [], "com.forgerock.openam.oauth2provider.tokenEndPointAuthMethod": "client_secret_post"}' "${openam}/json/agents?_action=create&_prettyPrint=true"

