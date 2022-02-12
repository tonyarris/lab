#!/bin/bash

# runs kali docker container & sets mount poin
sudo docker run -v $(pwd)/../client:/root/client --net=host -it kali /bin/bash
