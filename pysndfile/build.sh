#!/bin/bash


cd libogg-src
./configure  --prefix=$PREFIX
make
make install

cd ../libvorbis-src
./configure  --prefix=$PREFIX
make
make install

cd ../libflac-src
./configure  --prefix=$PREFIX
make
make install

cd ../libsndfile-src
./configure  --prefix=$PREFIX
make
make install
cd ..
python setup.py build_ext --sndfile-libdir=$PREFIX/lib --sndfile-incdir=$PREFIX/include
${PYTHON} setup.py install 

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
