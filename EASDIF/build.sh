#! /bin/bash

export CVSROOT=:ext:@sdif.cvs.sourceforge.net:/cvsroot/sdif/
cvs -z3 -d:pserver:anonymous:@sdif.cvs.sourceforge.net:/cvsroot/sdif co -P EASDIF_SDIF 

mkdir -p build_easdif
cd build_easdif
cmake ../EASDIF_SDIF -DPYTHON:PATH=python3 -DEASDIF_DO_PYTHON:bool=on
make pythonswig
make install_python_easdif_module_globally
#cd ..
#rm -f *~
#rm -rf EASDIF_SDIF
#rm -rf build_easdif
