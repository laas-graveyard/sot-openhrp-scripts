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

CONFIGURE_FILE(
  "hrp2_10-sot.xml.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/hrp2_10-sot.xml"
  IMMEDIATE
  )
CONFIGURE_FILE(
  "hrp2_14-sot-robot.xml.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/hrp2_14-sot-robot.xml"
  IMMEDIATE
  )
CONFIGURE_FILE(
  "hrp2_14-sot-simu.xml.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/hrp2_14-sot-simu.xml"
  IMMEDIATE
  )
INSTALL(
    FILES
      ${CMAKE_CURRENT_BINARY_DIR}/hrp2_14-sot-robot.xml
      ${CMAKE_CURRENT_BINARY_DIR}/hrp2_14-sot-simu.xml
      ${CMAKE_CURRENT_BINARY_DIR}/hrp2_10-sot.xml
    DESTINATION share/sot-openhrp/project
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)
