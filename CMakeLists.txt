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
SET(PROJECT_VERSION 1.0.0.99)
SET(PROJECT_DESCRIPTION "")
SET(PROJECT_URL "")

SETUP_PROJECT()

SET(${PROJECT_NAME}_HEADERS)

ADD_SUBDIRECTORY(doc)
ADD_SUBDIRECTORY(projects-openhrp)
ADD_SUBDIRECTORY(scripts-openhrp)
ADD_SUBDIRECTORY(scripts-sot)

# Desktop files.
FIND_PATH(
  OPENHRP_HOME bin/unix/GrxUI.sh
  DOC "OpenHRP home directory"
  NO_DEFAULT_PATH
  )
IF(NOT OPENHRP_HOME)
  MESSAGE(FATAL_ERROR "Failed to find the OpenHRP home (root) directory.")
ENDIF(NOT OPENHRP_HOME)

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
