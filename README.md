# blktrace
yum install blktrace -y

sudo mount -t debugfs debugfs /sys/kernel/debug

blktrace -d /dev/dm-5 -w 60 -o - | blkparse -i -

blktrace -d /dev/dm-6 -a issue -a complete -w 60 -o - | blkiomon  -I 2 -h -

blktrace -d /dev/dm-5 /dev/dm-6 -w 60

blkparse -i dm-6 -d dm-6.bin -o dm-6.txt

btt -i dm-6.bin -o dm-6

btt -i dm-6.bin -l dm-6.d2c_latency

iowatcher -t dm-6.bin -o dm-6.svg

fio  --name=replay --filename=/dev/dm-7 --thread --direct=1 --read_iolog=dm-5.bin

strace -o  strace.out fio  --name=replay --filename=/dev/dm-7 --thread --direct=1 --read_iolog=dm-5.bin

yum install gnuplot -y

https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-amd64.tar.gz

tar xvzf pandoc-2.19.2-linux-amd64.tar.gz --strip-components 1 -C /usr/local/

pandoc -v

ln -s /usr/local/bin/pandoc /usr/bin/pandoc

For PDF output, you’ll need LaTeX.

yum install texlive –y

-------LaTeX Error: File `translator.sty' not found.

https://ctan.org/search?phrase=translator

unzip -d /usr/share/texlive/texmf-dist/tex/latex/ translator.zip

-----------psutil

pip install psutil

