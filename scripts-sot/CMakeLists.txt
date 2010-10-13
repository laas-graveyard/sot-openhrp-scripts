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

INCLUDE(sot-scripts.cmake)

# Search for required directories.
FIND_PATH(
  HRP2_MODEL_DIRECTORY HRP2JRLmain.wrl
  DOC "HRP-2 model directory"
  NO_DEFAULT_PATH
  )

FIND_PATH(
  HRP2_CONFIG_DIRECTORY HRP2LinkJointRank.xml
  DOC "HRP-2 configuration directory"
  NO_DEFAULT_PATH
  )

IF(NOT HRP2_MODEL_DIRECTORY)
  MESSAGE(FATAL_ERROR "Failed to find the HRP-2 model directory.")
ENDIF(NOT HRP2_MODEL_DIRECTORY)
IF(NOT HRP2_CONFIG_DIRECTORY)
  MESSAGE(FATAL_ERROR "Failed to find the HRP-2 configuration directory.")
ENDIF(NOT HRP2_CONFIG_DIRECTORY)


# Variables required for script generation.
SET(DYN_LIB_EXT ${CMAKE_SHARED_LIBRARY_SUFFIX})

SET(DG_SCRIPT_DIR ${CMAKE_INSTALL_PREFIX}/share/dynamic-graph/script)
SET(PLUGIN_LIST_FILENAME plugin.txt)


#  Where is the trace repository?
#  FIXME: this is wrong. Trace output should go to a better place.
IF(WIN32)
  SET(TRACE_REPOSITORY "C:/tmp/")
ELSEIF(UNIX)
    SET(TRACE_REPOSITORY "/tmp/")
ENDIF(WIN32)

INSTALL_GENERATED_SOT_SCRIPTS(share/dynamic-graph/script
  hri_init
  base
  cmake_install
  dyn
  dynfilessmall
  collisiondetection
  dynsmall
  dynfiles
  traces
  walkreact-force
  hwpgpginitpart1
  dynsmallpart1hrp2_10_old
  simu
  dynsmallpart1hrp2_10
  coshell
  dynfilessmallhrp2_10_old
  dynfilessmallhrp2_10
  dynmc
  sot-scripts
  simusmall
  walkreact-joystick
  plugin.txt
  hwpgpginit
  walkreact-new
  hwpgpginitpart1hrp2_10
  hwpg
  )

INSTALL_SOT_SCRIPTS(share/dynamic-graph/script
  handsAltitude
  pgcom
  stepping
  walkreact
  forcehrp2_10
  acc
  selector
  small
  traj
  calibhrp2_10
  griphr2_10
  smallmchrp2_10
  forceSimu
  walkreactrobotatcwe
  smallmc
  detrace.awk
  jointlimit
  hwpgpginitpart2
  base.in
  forceLhrp2_10
  smallhrp2_10
  soth
  calib
  forceL
  hwpginitframes
  dynsmallpart2
  taskPosturehrp2_10
  grip
  force
  sothhrp2_10
  clamp-workspace
  acchrp2_10
  dynsmallpart2hrp2_10
  taskPosture
  )

# hri
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/hri hri/hri)

# optimization
INSTALL_GENERATED_SOT_SCRIPTS(share/dynamic-graph/script/optimization
  optimization/frigoSmall
  optimization/frigoSmallhrp2_10_small
  )
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/optimization
  optimization/frigo
  optimization/frigohrp2_10_small
  )

# stab
INSTALL_GENERATED_SOT_SCRIPTS(share/dynamic-graph/script/stab
  stab/flexibility
  )
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/stab
  stab/flex
  stab/sylvain
  )

# task-learning
INSTALL_GENERATED_SOT_SCRIPTS(
  share/dynamic-graph/script/taskLearning
  taskLearning/taskLearning
  )

# teleoperation
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/teleoperation
  teleoperation/data_epfl
  teleoperation/initConnec
  teleoperation/initConnecVFwave
  teleoperation/teleophrp2_10
  teleoperation/teleopVFwave
  teleoperation/data_tum
  teleoperation/initConnecAll
  teleoperation/teleop
  teleoperation/teleophrp2_small
  teleoperation/firfilter
  teleoperation/initConnecPhantom
  teleoperation/teleopAll
  teleoperation/teleop_traces
  )

# unittests
INSTALL_GENERATED_SOT_SCRIPTS(share/dynamic-graph/script/unittests
  unittests/chronoQr
  unittests/testInertia
  )
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/unittests
  unittests/chrono
  unittests/ik_arm
  unittests/ik_arm_sensor
  unittests/ik_arm_sensor_passive
  unittests/ik_arm_sensor_vel
  unittests/ik_com
  unittests/ik_jl_arm
  unittests/readme
  unittests/sotUnit.py
  )

# walking
INSTALL_GENERATED_SOT_SCRIPTS(share/dynamic-graph/script/walking
  walking/hwpgfeettasksrel
  )
INSTALL_SOT_SCRIPTS(share/dynamic-graph/script/walking
  walking/circle
  walking/hwpgfeettasks
  walking/hwpgjoints
  walking/hwpgjointsbscw
  walking/hwpgjointsteleop
  walking/hwpgreact
  walking/hwpgrefs
  walking/startherdt
  walking/startherdtsteppos
  walking/stepping
  walking/teststeps
  walking/teststeps2
  walking/teststeps3
  walking/teststeps3small
  walking/walk
  walking/walkreact
  )
