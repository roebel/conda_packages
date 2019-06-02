Conda Packages for Anaconda channel roebel
==========================================

These build recipies for the Anconda distribution are used to create packages of the Anaconda channel
roebel. Currently only Linux and MacOSX 64-bit versions are tested and provided via the pblic channel.

Compilation for 32bit Linux and MacOSX should be possible, Windows compilation has not been implemented
 and would require external contributions.

The current release covers the following modules that are extensively used for sound signal procesing at IRCAM:

pysndfile: python interface to libsndfile Erik de Castro Lopo's versatile sndfile library however disabling support for compressed (flac and ogg formats) (see: [https://pypi.python.org/pypi/pysndfile] and [http://www.mega-nerd.com/libsndfile])

easdif: python interface to eaSDIF library for reading SDIF (sound descrption interchange file format) 
   (see: [http://sdif.sourceforge.net])

pyfftw: python interface to the FFTw dft library (see: [https://pypi.python.org/pypi/pyFFTW], [http://www.fftw.org/])

py_find_1st: a numpy extension that allows to find the first index into an 1D-array that validates a boolean (see: [https://pypi.org/project/py_find_1st](https://pypi.org/project/py_find_1st/))
