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

# Variables required for script generation.
SET(SEQPLAYERTYPENAME "SequencePlayer")
SET(SOT_OPENHRP_SCRIPTS_DIR
	"${CMAKE_INSTALL_PREFIX}/share/sot-openhrp/script")

# Scripts list.
SET(SCRIPTS
  TestHWPGinSOT.py
  TestStackOfTasksV3.py
  demoBSCWreviewmeeting.py
  sotGeometry.py
  sotSOTH.py
  sotTaskLearning.py
  sotTeleopV3.py
  sotTeleopV3nonemodal.py
  sotTutorial.py
  sotWalkTask.py
  sotWalkTaskDemoROBOTatCWE.py
  sotWalkTaskGeometry.py
  sot_plugin.py
  )

FOREACH(SCRIPT ${SCRIPTS})
  # Generate script.
  CONFIGURE_FILE(${SCRIPT}.cmake ${CMAKE_CURRENT_BINARY_DIR}/${SCRIPT})

  # Install it.
  INSTALL(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/${SCRIPT}
    DESTINATION share/sot-openhrp/script
    PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
    )
ENDFOREACH(SCRIPT ${SCRIPTS})

INSTALL(
    FILES abstract_experiment.py tutorial.py
    DESTINATION share/sot-openhrp/script
    PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
)
