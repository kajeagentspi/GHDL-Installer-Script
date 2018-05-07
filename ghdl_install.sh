#!/bin/bash
# Commands from
# https://theintobooks.wordpress.com/2016/08/24/installing-ghdl-from-source-on-ubuntu-16-04/
# change permissions first
# chmod a+x ghdl_install.sh
# then run with sudo
# sudo bash ghdl_install.sh
sudo apt install libmpfr-dev zlib1g-dev -y

set -e
git clone git://git.code.sf.net/p/ghdl-updates/ghdl-updates.git
cd ghdl-updates
git checkout ghdl-0d.33
apt install gnat gtkwave m4 -y
wget ftp://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2
tar xvjf gcc-4.9.4.tar.bz2
./configure --with-gcc=gcc-4.9.4/
make copy-sources

# install gmp
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
tar xvjf gmp-4.3.2.tar.bz2
mkdir gmp-4.3.2/gmp-objs/
cd gmp-4.3.2/gmp-objs/
../configure --prefix=/usr/local --disable-shared
make
make install
cd ../..

# install mpfr
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
tar xvjf mpfr-2.4.2.tar.bz2
mkdir mpfr-2.4.2/mpfr-objs/
cd mpfr-2.4.2/mpfr-objs/
../configure --prefix=/usr/local --disable-shared --with-gmp=/usr/local
make
make install
cd ../..

# install mpc
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.2.tar.gz
tar xvzf mpc-0.8.2.tar.gz
mkdir mpc-0.8.2/mpc-objs/
cd mpc-0.8.2/mpc-objs/
../configure --prefix=/usr/local --disable-shared --with-gmp=/usr/local
make
make install
cd ../..

# Install 
cd gcc-4.9.4
mkdir gcc-objs
cd gcc-objs/
../configure --prefix=/opt/ghdl-updates --enable-languages=c,vhdl --disable-bootstrap --with-gmp=/usr/local --disable-lto --disable-multilib
PATH=/usr/lib/gcc/x86_64-linux-gnu/4.9:$PATH make
PATH=/usr/lib/gcc/x86_64-linux-gnu/4.9:$PATH make install MAKEINFO=true


ln -s /opt/ghdl-updates/bin/ghdl /bin/ghdl
rm -rf ghdl-updates
