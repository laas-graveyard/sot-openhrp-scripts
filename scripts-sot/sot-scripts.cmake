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

# INSTALL_GENERATED_SOT_SCRIPTS(DESTINATION SCRIPTS...)
# -----------------------------------------------------
#
#  Generate the scripts using CMake and install them.
#
# DESTINATION  : installation directory
# SCRIPTS      : scripts list
#
FUNCTION(INSTALL_GENERATED_SOT_SCRIPTS)
  SET(DESTINATION ${ARGV0})
  MATH(EXPR END ${ARGC}-1)

  FOREACH(I RANGE 1 ${END})
    SET(SCRIPT ${ARGV${I}})
    # Generate script.
    CONFIGURE_FILE(${SCRIPT}.cmake ${CMAKE_CURRENT_BINARY_DIR}/${SCRIPT})

    # Install it.
    INSTALL(
      FILES ${CMAKE_CURRENT_BINARY_DIR}/${SCRIPT}
      DESTINATION ${ARGV0}
      PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
      )
  ENDFOREACH(I RANGE 1 ${END})
ENDFUNCTION(INSTALL_GENERATED_SOT_SCRIPTS)


# INSTALL_SOT_SCRIPTS(DESTINATION SCRIPTS...)
# -------------------------------------------
#
#  Generate the scripts using CMake and install them.
#
# DESTINATION  : installation directory
# SCRIPTS      : scripts list
#
FUNCTION(INSTALL_SOT_SCRIPTS)
  SET(DESTINATION ${ARGV0})
  MATH(EXPR END ${ARGC}-1)
  FOREACH(I RANGE 1 ${END})
    SET(SCRIPT ${ARGV${I}})
     INSTALL(
      FILES ${SCRIPT}
      DESTINATION ${DESTINATION}
      PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
      )
  ENDFOREACH(I RANGE 1 ${END})
ENDFUNCTION(INSTALL_SOT_SCRIPTS)
