#!/usr/bin/env bash
# Build Docker images
# Usage: ./build image [-d] [-p] image-dir
# Options
# -d download: runs mvn package to get latest software bits
# -p push the image to the registry

# ENV vars for the registry / repo and tags
REPO=${REPO:-forgerock}
TAG=${TAG:-latest}

# To test this script uncomment this
#DRYRUN="echo"
DRYRUN=""


# If you add new docker images add them here
IMAGES="apache-agent openam opendj openidm openidm-postgres openig resty ssoadm ssoconfig openam-onbuild openidm-onbuild"


function download {
     echo "downloading software"
      mvn package
}



function buildDocker {
   ${DRYRUN} docker build -t ${REPO}/$1:${TAG} $1
   if [[ -v PUSH ]]; then
      ${DRYRUN} docker push ${REPO}/$1
   fi
}

while getopts "dp" opt; do
  case ${opt} in
    d) # process option a
      download
      ;;
    p ) # process option l
      PUSH="1"
      ;;
    \? )
         echo "Usage: build [-d] [-p] image"
         echo "-d downloads ForgeRock binaries in maven pom.xml, -p push images to registry after building"
      ;;
  esac
done
shift $((OPTIND -1))




if [ "$#" -eq "0" ]; then
   echo "Building All images"
   for image in $IMAGES; do
      buildDocker $image
   done
else
   echo "Building $@"
   buildDocker $@
fi
