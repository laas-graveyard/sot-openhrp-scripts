sot-openhrp
===========

This package contains scripts for operation of the stack of tasks
(SoT, see package sot-core for more information) with OpenHRP.


Two different sorts of scripts are provided:
 - example python scripts for OpenHRP (the most relevant being
   sotWalkTask.py),
 - (necessary) initialisation scripts for the stack of tasks (written
   in the SoT scripting language).


The version of OpenHRP currently supported is: version 3.0.5; the
scripts have been tested with the robot HRP2-10.


Setup
-----

To compile this package, it is recommended to create a separate build
directory:

    mkdir _build
    cd _build
    cmake [OPTIONS] ..
    make install

Please note that CMake produces a `CMakeCache.txt` file which should
be deleted to reconfigure a package from scratch.

By building this package, you install the scripts in two different installation directories:

- `${OPENHRP_HOME}/Controller/IOServer/${ROBOT}/scripts` directory
  for python scripts,
- `${CMAKE_INSTALL_PREFIX}/script` directory for SOT scripts
