# blktrace
yum install blktrace -y

sudo mount -t debugfs debugfs /sys/kernel/debug

blktrace -d /dev/dm-5 -w 60 -o - | blkparse -i -

blktrace -d /dev/dm-5 -a issue -a complete -w 60 -o - | blkiomon  -I 2 -h -

blktrace -d /dev/dm-5 /dev/dm-6 -w 60

blkparse -i dm-6 -d dm-6.bin -o dm-6.txt

btt -i dm-6.bin -o dm-6

btt -i dm-6.bin -l dm-6.d2c_latency

iowatcher -t dm-6.bin -o dm-6.svg

./blkmon.sh /dev/dm-6
