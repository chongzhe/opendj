# Docker build files for the ForgeRock stack

## Warning
**This code is not supported by ForgeRock and it is your responsibility to verify that the software is suitable and safe for use.**

## Contributing 

If you are reading this on github, this is a mirror of the master 
repo at https://stash.forgerock.org/projects/DOCKER/repos/docker/browse 

Any pull requests or issues should be filed on the stash project. You 
will need a ForgeRock community account to create PRs or issues.

To create a pull request, fork the project to your private community stash account, clone it to your workstation,
commit your changes and push them up to your stash account. You can create a pull request on stash.



## About

This is very much a work in progress. You will need to modify the Dockerfiles here to suit
your needs. The Dockerfiles are changing quite often as we find better ways to build these images
for a wide range of requirements. 

Some of the Docker images dynamically pull the ForgeRock assets from maven, and some
expect that the war or zip is already downloaded to the directory containing the Dockerfile.


The provided Makefile and build scripts downloads nightly builds from ForgeRock's maven repo
and will build and tag the docker images

To build

```
make clean
make
```

# Getting Started Example using OpenAM

The openam-onbuild contains a Docker image is a good place to start. There is sample/ directory 
in that image that will build and configure a child image. Please see the README



# Building Docker Images using Jenkins

If you have a Jenkins CI pipeline, you can automatically build these images:
 * Check this repo out of git
 * Copy the relevant war or zip file from ForgeRock's maven repo
 * Use the Jenkins Docker plugin to perform a docker build, tag and push the image.


# Building Minor or Patch Releases

If you want to use a major or minor release (OpenAM 13.0.1, for example), log on to
backstage.forgerock.com and download the appropriate binary. The binary should be
placed in the Docker build directory (e.g. openam/) and should not have any
version info (openam.war, not OpenAM-13.0.1.war).

Note that some images directly pull from maven -so you may need to modify the Dockerfile

If you are interested in running on a Kubernetes cluster,
see  [here](https://github.com/ForgeRock/fretes)


# How to run these images

Please see the README.md in each directory.  If you want to run OpenAM you probably want to start
with the openam-onbuild image. 
