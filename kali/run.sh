#!/bin/bash

# runs kali docker container & sets mount poin
sudo docker run -v /home/ubuntu/lab/client:/root/client --net=host -it kali /bin/bash
