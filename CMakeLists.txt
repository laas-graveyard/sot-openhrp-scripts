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
INCLUDE(cmake/cpack.cmake)

SET(PROJECT_NAME sot-openhrp-scripts)
SET(PROJECT_DESCRIPTION
  "Python and dynamic-graph scripts associated to the sot-openhrp package.")
SET(PROJECT_URL "http://github.com/jrl-umi3218/sot-openhrp-scripts")

SETUP_PROJECT()

ADD_REQUIRED_DEPENDENCY("sot-openhrp >= 1.0.0")
ADD_REQUIRED_DEPENDENCY("sot-dynamic >= 1.0.0")
ADD_REQUIRED_DEPENDENCY("sot-pattern-generator >= 1.0.0")
ADD_REQUIRED_DEPENDENCY("dynamic-graph >= 1.0.0")
ADD_REQUIRED_DEPENDENCY("dg-middleware >= 1.1.0")

# Search for closed-source packages.
ADD_OPTIONAL_DEPENDENCY("hrp2-10 >= 1.0.0")
ADD_OPTIONAL_DEPENDENCY("hrp2-14 >= 1.0.0")


# Deduce directories location.
SET(HRP2_10_MODEL_DIRECTORY ${HRP2_10_PKGDATAROOTDIR})
SET(HRP2_MODEL_DIRECTORY ${HRP2_14_PKGDATAROOTDIR})

# Watch interesting variables.
LIST(APPEND LOGGING_WATCHED_VARIABLES
  HRP2_10_MODEL_DIRECTORY
  HRP2_14_MODEL_DIRECTORY
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
SETUP_PROJECT_CPACK()
