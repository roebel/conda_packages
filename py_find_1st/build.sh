#!/bin/bash

# use python from build environement for building
# and python from host environment for installing
python setup.py build_ext
$PYTHON setup.py install 

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
