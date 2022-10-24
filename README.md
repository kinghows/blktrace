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

--------------

python3 blkreport.py -d dm-4

-----------------iowatcher

http://masoncoding.com/iowatcher/

iowatcher -t dm-5.bin -o dm-5.svg

iowatcher -t dm-5.bin -t dm-6.bin -l dm-5 -l dm-6 -o dm.svg

----------------ioprof
https://github.com/intel/ioprof

./ioprof.pl -m trace -d /dev/dm-4 -r 60

./ioprof.pl -m trace -d /dev/dm-5 -r 60

./ioprof.pl -m trace -d /dev/dm-6 -r 60

./ioprof.pl -m post -t dm-4.tar -p

./ioprof.pl -m post -t dm-5.tar -p

./ioprof.pl -m post -t dm-6.tar -p

--------------seekwatcher

https://github.com/trofi/seekwatcher

pip3 install numpy

pip3 install Cython

yum -y install libjpeg-turbo-devel

yum -y install python3-devel

pip3 install Pillow

pip3 install matplotlib

ln -s /usr/bin/python3.6 /usr/bin/python

python setup.py install 

blktrace -d /dev/dm-4 /dev/dm-5 /dev/dm-6 -w 10

seekwatcher -t dm-4 -o dm-4.png

seekwatcher -t dm-5 -o dm-5.png

seekwatcher -t dm-6 -o dm-6.png

seekwatcher -t dm-4 -t dm-5 -t dm-6 -l dm-4 -l dm-5 -l dm-6 -o dm-456.png

