#!/bin/bash

git clone git+ssh://git@git.forge.ircam.fr/as_pysrc.git
cd as_pysrc
make install
rsync -a --exclude "shell_support/" --exclude "adapt/" --exclude "transposition_script/" --exclude "shell_scripts/" --include '*/' --include '*.py' --exclude '*' * $PREFIX/lib/python3.6/site-packages/
cd ..
