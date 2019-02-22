#!/bin/sh

cd /
git clone https://github.com/postgrespro/pg_pathman.git
cd pg_pathman
git checkout -b 1.5.3 1.5.3
make install USE_PGXS=1

cd /
wget http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2
tar xf scws-1.2.3.tar.bz2
cd scws-1.2.3
./configure
make install

cd /
git clone https://github.com/amutu/zhparser.git
cd zhparser
make
make install

