# 
#  Copyright 
# 


# --- OpenHRP 3 -----------------------------------------------------------
IF(OPENHRP_VERSION_3)

    SET(HRP_ROBOT_SPEC ${ROBOT} CACHE STRING "Robot name, to resolve specific path in OpenHRP.")

	SET(SOT_OPENHRP_SCRIPT_INSTALL_DIR "${OPENHRP_HOME}/Controller/IOserver/robot/${ROBOT}/script")
	SET(SOT_OPENHRP_SCRIPT_BUILD_DIR ${CMAKE_BINARY_DIR}/script)

    # --- SCRIPT GENERATION AND INSTALL -----------------------------------------------------
    SET(SEQPLAYERTYPENAME "SequencePlayer")
    SET(SOT_OPENHRP_SCRIPT_TO_INSTALL 
          TestStackOfTasksV3.py.cmake
          sotTeleopV3.py.cmake
	  sotTeleopV3nonemodal.py.cmake
	  sotGeometry.py.cmake
	  sotTaskLearning.py.cmake
	  sotWalkTask.py.cmake
	  sotSOTH.py.cmake
	  sotWalkTaskGeometry.py.cmake
	  sot_plugin.py.cmake
	  TestHWPGinSOT.py.cmake
	  TestHWPGinSOT.py.cmake
	  demoBSCWreviewmeeting.py.cmake
	  sotWalkTaskDemoROBOTatCWE.py.cmake
      sotTutorial.py.cmake
	  )

    FOREACH(SCRIPT_NAME ${SOT_OPENHRP_SCRIPT_TO_INSTALL})
      SET(cmakeextension "\\.cmake")
      STRING(REGEX REPLACE "${cmakeextension}$" "" TARGET_NAME ${SCRIPT_NAME})
      CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/${SCRIPT_NAME}
   	             ${SOT_OPENHRP_SCRIPT_BUILD_DIR}/${TARGET_NAME})
      INSTALL(FILES ${SOT_OPENHRP_SCRIPT_BUILD_DIR}/${TARGET_NAME}
	      DESTINATION ${SOT_OPENHRP_SCRIPT_INSTALL_DIR}
	      PERMISSIONS OWNER_READ GROUP_READ WORLD_READ)
   ENDFOREACH(SCRIPT_NAME)
ELSE(OPENHRP_VERSION_3)
	MESSAGE("Could not install OpenHRP scripts (ether this version of OpenHRP is not supported, or OpenHRP was not found")
ENDIF(OPENHRP_VERSION_3)

