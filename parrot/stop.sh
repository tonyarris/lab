#!/bin/bash

# stops all containers
for i in $(sudo docker container ls -a -q); do sudo docker stop $i; done
