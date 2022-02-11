#!/bin/bash

# builds the container - to run after a change to the dockerfile manifest and on a regular basis to keep the container updated
sudo docker build --no-cache -t kali .
