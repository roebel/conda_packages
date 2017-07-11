#!/bin/bash

curl http://www.fftw.org/fftw-3.3.6-pl2.tar.gz -o fftw-3.3.6-pl2.tar.gz
tar -xvzf fftw-3.3.6-pl2.tar.gz
cd fftw-3.3.6-pl2
configure  --prefix=$PREFIX  --enable-threads --disable-fortran
make
make install
configure  --prefix=$PREFIX --enable-single --enable-threads --disable-fortran
make
make install
configure  --prefix=$PREFIX --enable-long-double --enable-threads --disable-fortran
make
make install

cd ..

$PYTHON setup.py build_ext --include-dirs=$PREFIX/include --library-dirs=$PREFIX/lib
$PYTHON setup.py install 

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
