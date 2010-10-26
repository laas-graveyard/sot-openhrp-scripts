# Copyright (C) 2010 François Bleibel, Thomas Moulard, JRL, CNRS/AIST.
#
# This file is part of sot-openhrp-scripts.
# sot-openhrp-scripts is free software: you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# sot-openhrp-scripts is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Lesser Public License for more details.  You should have
# received a copy of the GNU Lesser General Public License along with
# sot-openhrp-scripts. If not, see <http://www.gnu.org/licenses/>.

# Search for required directories.
FIND_PATH(
  HRP2_SCRIPT_DIR hrp.py
  DOC "HRP-2 script directory"
  ENV HRP2_SCRIPT_DIR
  )

IF(NOT HRP2_SCRIPT_DIR)
  MESSAGE(FATAL_ERROR "Failed to find the HRP-2 script directory.")
ENDIF(NOT HRP2_SCRIPT_DIR)

CONFIGURE_FILE(
  "abstract_experiment.py.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/abstract_experiment.py"
  IMMEDIATE
  )


CONFIGURE_FILE(
  "hrp2_10-default.py.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/hrp2_10-default.py"
  IMMEDIATE
  )


INSTALL(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/abstract_experiment.py
    DESTINATION share/sot-openhrp/script
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)

INSTALL(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/hrp2_10-default.py
    DESTINATION share/sot-openhrp/script
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)

INSTALL(
    FILES hrp2_14-default.py
    DESTINATION share/sot-openhrp/script
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)
