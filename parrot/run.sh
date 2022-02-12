#/bin/bash

# start container and create mount point
sudo docker run -v $(pwd)/../client:/root/client --net=host -it parrot /bin/bash
