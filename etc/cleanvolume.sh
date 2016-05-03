#!/bin/bash 
# Script to clean up all volumes

docker volume rm $(docker volume ls -qf dangling=true)
