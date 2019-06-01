#! /bin/bash

svn checkout  svn://svn.code.sf.net/p/sdif/code/trunk/Easdif EASDIF_SDIF

echo $CONDA_NPY
mkdir -p build_easdif
cd build_easdif
cmake ../EASDIF_SDIF -DPYTHON:PATH=python3 -DEASDIF_DO_PYTHON:bool=on
make pythonswig
make install_python_easdif_module_globally
#cd ..
#rm -f *~
#rm -rf EASDIF_SDIF
#rm -rf build_easdif
