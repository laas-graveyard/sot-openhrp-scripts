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

By building this package, you install the scripts in different installation directories:
- HRP2_SCRIPT_DIR for python script with openhrp
- `${CMAKE_INSTALL_PREFIX}/share/sot-openhrp/` directory
  for python scripts,
- `${CMAKE_INSTALL_PREFIX}/share/dynamic-grap/script` directory for SOT scripts

CMAKE must have the following directory set:
- HRP2_SCRIPT_DIR typically:/opt/grx3.0/HRP2JRL/script
- HRP2_CONFIG_DIR:/opt/openrobots/share/hrp2-10
- HRP2_MODEL_DIRECTORY:/opt/grx3.0/HRP2JRL/model

You can choose your robot by setting HRP2_NAME using:
HRP2_NAME=hrp2-10 
or
HRP2_NAME=hrp2-14

this gives for instance:
cmake \ 
../pkgsrc \ 
-DCMAKE_INSTALL_PREFIX=/opt/openrobots/ \ 
-DCMAKE_BUILD_TYPE=RELEASE \ 
-DHRP2_SCRIPT_DIR=/opt/grx3.0//HRP2JRL/script/ \ 
-DHRP2_CONFIG_DIRECTORY=/opt/openrobots//share/hrp2-10 \
-DHRP2_MODEL_DIRECTORY=/opt/grx3.0//HRP2JRL/model
-DHRP2_NAME=hrp2-10