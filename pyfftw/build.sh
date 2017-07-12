#!/bin/bash

cd fftw-src
unset CFLAGS
unset LD_FLAGS
configure  --prefix=$PREFIX  --enable-shared --enable-long-double --enable-threads --disable-fortran
make
make install
configure  --prefix=$PREFIX  --enable-shared --enable-single --enable-threads --disable-fortran --enable-sse --enable-avx 
make
make install
configure  --prefix=$PREFIX  --enable-shared --enable-threads --disable-fortran --enable-sse2 --enable-avx 
make
make install
cd ..

$PYTHON setup.py build_ext --include-dirs=$PREFIX/include --library-dirs=$PREFIX/lib
$PYTHON setup.py install 

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
