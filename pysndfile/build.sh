#!/bin/bash

curl http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz -o libsndfile-1.0.28.tar.gz
tar -xvzf libsndfile-1.0.28.tar.gz
cd libsndfile-1.0.28
configure --disable-external-libs --prefix=$PREFIX
make
make install
cd ..
$PYTHON setup.py build_ext --sndfile-libdir=$PREFIX/lib --sndfile-incdir=$PREFIX/include
$PYTHON setup.py install 

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
