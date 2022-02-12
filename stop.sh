#!/bin/bash

# stops and removes all containers
for i in $(sudo docker container ls -a -q); do sudo docker stop $i; done
for i in $(sudo docker container ls -aq); do sudo docker rm $i; done
