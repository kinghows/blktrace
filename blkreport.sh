#!/bin/bash

. /etc/profile

cd /root/monitor/blkreport/

blktrace -d /dev/dm-4 /dev/dm-5 /dev/dm-6 -w 60

python3 blkreport.py -d dm-4

python3 blkreport.py -d dm-5 

python3 blkreport.py -d dm-6

find . -regex '.*\.png\|.*\.result\|.*\.md'  -exec rm -rf {} \;




