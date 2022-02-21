#/bin/bash

# start container and create mount point
sudo docker run -v /home/ubuntu/lab/client:/root/client --net=host -it parrot /bin/bash
