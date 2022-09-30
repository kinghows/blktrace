# blktrace
yum install blktrace -y

sudo mount -t debugfs debugfs /sys/kernel/debug

blktrace -d /dev/dm-5 -w 60 -o - | blkparse -i -

blktrace -d /dev/dm-5 -a issue -a complete -w 60 -o - | blkiomon  -I 2 -h -

blktrace -d /dev/dm-5 /dev/dm-6 -w 60

blkparse -i dm-6 -o dm-6.txt

blkparse dm-6 -d dm-6.bin

blkparse dm-5 -d dm-5.bin

btt -i dm-6.bin -o dm-6

btt -i dm-5.bin -o dm-5

btt -i dm-5.bin -l dm-5.d2c_latency

