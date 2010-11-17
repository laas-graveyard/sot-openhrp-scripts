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

# Requires at least CMake 2.6 to configure the package.
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

INCLUDE(cmake/base.cmake)

SET(PROJECT_NAME sot-openhrp-scripts)
SET(PROJECT_DESCRIPTION
  "Python and dynamic-graph scripts associated to the sot-openhrp package.")
SET(PROJECT_URL "http://github.com/jrl-umi3218/sot-openhrp-scripts")

SETUP_PROJECT()

ADD_REQUIRED_DEPENDENCY("dynamic-graph")

# Search for closed-source packages.
ADD_REQUIRED_DEPENDENCY("hrp2_10-small")
ADD_REQUIRED_DEPENDENCY("hrp2_10-small-old")
ADD_REQUIRED_DEPENDENCY("hrp2_14")

# Search for OpenHRP root directory.
SET(OPENHRP_ROBOT HRP2JRL)
FIND_PATH(
  OPENHRP_HOME
  NAMES
   bin/unix/GrxUI.sh
   Controller/IOserver/robot/${OPENHRP_ROBOT}/script/hrp.py
   Controller/IOserver/robot/${OPENHRP_ROBOT}/model/HRP2JRLmain.wrl
  DOC "OpenHRP home directory"
  PATHS ENV OPENHRP_HOME
  PATHS ENV OPENHRPHOME # alternative syntax. I've seen both used.
  )
IF(NOT OPENHRP_HOME)
  MESSAGE(FATAL_ERROR "Failed to find the OpenHRP home (root) directory. Try setting your OPENHRP_HOME environment or cmake variable.")
ENDIF(NOT OPENHRP_HOME)

# Deduce directories location.
SET(HRP2_SCRIPT_DIR ${OPENHRP_HOME}/Controller/IOserver/robot/HRP2JRL/script)
SET(HRP2_MODEL_DIRECTORY
  ${OPENHRP_HOME}/Controller/IOserver/robot/${OPENHRP_ROBOT}/model)

# Watch interesting variables.
LIST(APPEND LOGGING_WATCHED_VARIABLES
  HRP2_SCRIPT_DIR
  HRP2_MODEL_DIRECTORY
  )

ADD_SUBDIRECTORY(projects-openhrp)
ADD_SUBDIRECTORY(scripts-openhrp)
ADD_SUBDIRECTORY(scripts-sot)

# Desktop files.
CONFIGURE_FILE(
  "share/applications/sot-openhrp.desktop.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/share/applications/sot-openhrp.desktop"
  IMMEDIATE
  )

INSTALL(
    FILES
      ${CMAKE_CURRENT_BINARY_DIR}/share/applications/sot-openhrp.desktop
    DESTINATION share/applications
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)
INSTALL(
    FILES
      ${CMAKE_CURRENT_SOURCE_DIR}/share/pixmaps/sot-openhrp.xpm
    DESTINATION share/pixmaps
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)


SETUP_PROJECT_FINALIZE()
