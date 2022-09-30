#!/bin/bash
 
if [ $# -ne 1 ]; then
        echo "Usage: $0 <block_device_name>"
        exit
fi
if [ ! -b $1 ]; then
        echo "could not find block device $1"
        exit
fi
 
duration=10
echo "running blktrace for $duration seconds to collect data..."
timeout $duration blktrace -d $1 >/dev/null 2>&1
 
DEVNAME=`basename $1`

echo "parsing blktrace data..."
blkparse -i $DEVNAME |sort -g -k8 -k10 -k4 |awk '
BEGIN   {
        total_read=0;
        total_write=0;
        maxwait_read=0;
        maxwait_write=0;
}
{
        if ($6=="Q") {
                queue_ts=$4;
                block=$8;
                nblock=$10;
                rw=$7;
        };
        if ($6=="C" && $8==block && $10==nblock && $7==rw) {
                await=$4-queue_ts;
                if (rw=="R") {
                        if (await>maxwait_read) maxwait_read=await;
                        total_read++;
                        read_count_block[nblock]++;
                        if (await>0.001) read_count1++;
                        if (await>0.01) read_count10++;
                        if (await>0.02) read_count20++;
                        if (await>0.03) read_count30++;
                }
                if (rw=="W" || rw=="WS") {
                        if (await>maxwait_write) maxwait_write=await;
                        total_write++;
                        write_count_block[nblock]++;
                        if (await>0.001) write_count1++;
                        if (await>0.01) write_count10++;
                        if (await>0.02) write_count20++;
                        if (await>0.03) write_count30++;
                }
        }
} END   {
        printf("========\nsummary:\n========\n");
        printf("total number of reads: %d\n", total_read);
        printf("total number of writes: %d\n", total_write);
        printf("slowest read : %.6f second\n", maxwait_read);
        printf("slowest write: %.6f second\n", maxwait_write);
        printf("reads\n> 1ms: %d\n>10ms: %d\n>20ms: %d\n>30ms: %d\n", read_count1, read_count10, read_count20, read_count30);
        printf("writes\n> 1ms: %d\n>10ms: %d\n>20ms: %d\n>30ms: %d\n", write_count1, write_count10, write_count20, write_count30);
        printf("\nblock size:%16s\n","Read Count");
        for (i in read_count_block)
                printf("%10d:%16d\n", i, read_count_block[i]);
        printf("\nblock size:%16s\n","Write Count");
        for (i in write_count_block)
                printf("%10d:%16d\n", i, write_count_block[i]);
}'

