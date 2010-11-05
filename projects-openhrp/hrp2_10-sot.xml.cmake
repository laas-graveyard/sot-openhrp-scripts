<?xml version="1.0" encoding="UTF-8"?>
<grxui>
  	<processmanagerconfig>
		<process autostart="false" com="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/bin/HRP2Controller$(BIN_SFX)" dir="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/bin/" hasshutdown="true" id="HRP2JRLControllerFactory" waitcount="2000"/>
	</processmanagerconfig>

    <mode name="Simulation">
        <item class="com.generalrobotix.ui.item.GrxWorldStateItem" name="untitled" select="true">
            <property name="useDisk" value="true"/>
            <property name="logTimeStep" value="0.0010 "/>
            <property name="integrate" value="true"/>
            <property name="viewsimulate" value="false"/>
            <property name="totalTime" value="30.0 "/>
            <property name="timeStep" value="0.0010 "/>
            <property name="method" value="RUNGE_KUTTA"/>
            <property name="gravity" value="9.8 "/>
            <property name="viewsimulationTimeStep" value="0.033 "/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxModelItem" name="HRP2JRL" select="true" url="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/model/HRP2JRLBush_main.wrl">
            <property name="isRobot" value="true"/>
            <property name="controlTime" value="0.0010"/>
            <property name="controller" value="HRP2JRLControllerFactory"/>
			<property name="setupDirectory" value="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/bin"/>
			<property name="setupCommand" value="HRP2Controller$(BIN_SFX)"/>
            <property name="imageProcessTime" value="0.033"/>
            <property name="imageProcessor" value=""/>
            <property name="WAIST.translation" value="0.0 0.0 0.6487 "/>
            <property name="WAIST.rotation" value="0.0 1.0 0.0 0.0 "/>
            <property name="WAIST.angle" value="0.0"/>
            <property name="RLEG_JOINT0.angle" value="0.0"/>
            <property name="RLEG_JOINT1.angle" value="0.0"/>
            <property name="RLEG_JOINT2.angle" value="-0.4538"/>
            <property name="RLEG_JOINT3.angle" value="0.8727"/>
            <property name="RLEG_JOINT4.angle" value="-0.4189"/>
            <property name="RLEG_JOINT5.angle" value="0.0"/>
            <property name="RLEG_BUSH_ROLL.angle" value="0.0"/>
            <property name="RLEG_BUSH_PITCH.angle" value="0.0"/>
            <property name="RLEG_BUSH_Z.angle" value="0.0"/>
            <property name="LLEG_JOINT0.angle" value="0.0"/>
            <property name="LLEG_JOINT1.angle" value="0.0"/>
            <property name="LLEG_JOINT2.angle" value="-0.4538"/>
            <property name="LLEG_JOINT3.angle" value="0.8727"/>
            <property name="LLEG_JOINT4.angle" value="-0.4189"/>
            <property name="LLEG_JOINT5.angle" value="0.0"/>
            <property name="LLEG_BUSH_ROLL.angle" value="0.0"/>
            <property name="LLEG_BUSH_PITCH.angle" value="0.0"/>
            <property name="LLEG_BUSH_Z.angle" value="0.0"/>
            <property name="CHEST_JOINT0.angle" value="0.0"/>
            <property name="CHEST_JOINT1.angle" value="0.0"/>
            <property name="HEAD_JOINT0.angle" value="0.0"/>
            <property name="HEAD_JOINT1.angle" value="0.0"/>
            <property name="RARM_JOINT0.angle" value="0.2618"/>
            <property name="RARM_JOINT1.angle" value="-0.1745"/>
            <property name="RARM_JOINT2.angle" value="0.0"/>
            <property name="RARM_JOINT3.angle" value="-0.5236"/>
            <property name="RARM_JOINT4.angle" value="0.0"/>
            <property name="RARM_JOINT5.angle" value="0.0"/>
            <property name="RARM_JOINT6.angle" value="0.0"/>
            <property name="RARM_JOINT7.angle" value="0.0"/>
            <property name="LARM_JOINT0.angle" value="0.2618"/>
            <property name="LARM_JOINT1.angle" value="0.1745"/>
            <property name="LARM_JOINT2.angle" value="0.0"/>
            <property name="LARM_JOINT3.angle" value="-0.5236"/>
            <property name="LARM_JOINT4.angle" value="0.0"/>
            <property name="LARM_JOINT5.angle" value="0.0"/>
            <property name="LARM_JOINT6.angle" value="0.0"/>
            <property name="LARM_JOINT7.angle" value="0.0"/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxModelItem" name="floor" select="true" url="$(OPENHRPHOME)/etc/longfloor.wrl">
            <property name="isRobot" value="false"/>
            <property name="WAIST.rotation" value="0.0 1.0 0.0 0.0 "/>
            <property name="WAIST.translation" value="0.0 0.0 -0.1 "/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxCollisionPairItem" name="CP#floor#HRP2JRL" select="true">
            <property name="springConstant" value="100000 100000 100000 800 800 800"/>
            <property name="slidingFriction" value="0.5"/>
            <property name="jointName2" value=""/>
            <property name="jointName1" value=""/>
            <property name="sprintDamperModel" value="false"/>
            <property name="damperConstant" value="100000 100000 100000 800 800 800"/>
            <property name="objectName2" value="HRP2JRL"/>
            <property name="objectName1" value="floor"/>
            <property name="staticFriction" value="0.5"/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxGraphItem" name="GraphList1" select="true">
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.numSibling" value="3"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.node" value="gyrometer"/>
            <property name="Graph0.Graph0_HRP2JRL_lfsensor_force_2.object" value="HRP2JRL"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.node" value="gsensor"/>
            <property name="Graph0.Graph0_HRP2JRL_rfsensor_force_2.object" value="HRP2JRL"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.numSibling" value="3"/>
            <property name="Graph0.Graph0_HRP2JRL_lfsensor_force_2.node" value="lfsensor"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.node" value="gsensor"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.attr" value="angularVelocity"/>
            <property name="Graph0.Graph0_HRP2JRL_rfsensor_force_2.attr" value="force"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.color" value="yellow"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.attr" value="angularVelocity"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.color" value="green"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.numSibling" value="3"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.color" value="pink"/>
            <property name="Graph2.dataItems" value="Graph2_HRP2JRL_gyrometer_angularVelocity_0,Graph2_HRP2JRL_gyrometer_angularVelocity_1,Graph2_HRP2JRL_gyrometer_angularVelocity_2"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.legend" value="HRP2JRL.gyrometer.angularVelocity.0"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.object" value="HRP2JRL"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.index" value="1"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.index" value="0"/>
            <property name="Graph0.Graph0_HRP2JRL_lfsensor_force_2.index" value="2"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.index" value="2"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.legend" value="HRP2JRL.gyrometer.angularVelocity.1"/>
            <property name="Graph0.dataItems" value="Graph0_HRP2JRL_lfsensor_force_2,Graph0_HRP2JRL_rfsensor_force_2"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.object" value="HRP2JRL"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.attr" value="acceleration"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.numSibling" value="3"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.legend" value="HRP2JRL.gyrometer.angularVelocity.2"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.legend" value="HRP2JRL.gsensor.acceleration.0"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.object" value="HRP2JRL"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_0.node" value="gyrometer"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.object" value="HRP2JRL"/>
            <property name="Graph0.Graph0_HRP2JRL_rfsensor_force_2.node" value="rfsensor"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.numSibling" value="3"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_2.node" value="gyrometer"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.legend" value="HRP2JRL.gsensor.acceleration.1"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.color" value="yellow"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.color" value="green"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.object" value="HRP2JRL"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.color" value="pink"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.legend" value="HRP2JRL.gsensor.acceleration.2"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.index" value="1"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.object" value="HRP2JRL"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.index" value="0"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.index" value="2"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_1.node" value="gsensor"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.numSibling" value="3"/>
            <property name="Graph3.dataItems" value=""/>
            <property name="Graph0.Graph0_HRP2JRL_rfsensor_force_2.index" value="2"/>
            <property name="Graph2.Graph2_HRP2JRL_gyrometer_angularVelocity_1.attr" value="angularVelocity"/>
            <property name="Graph1.dataItems" value="Graph1_HRP2JRL_gsensor_acceleration_0,Graph1_HRP2JRL_gsensor_acceleration_1,Graph1_HRP2JRL_gsensor_acceleration_2"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_0.attr" value="acceleration"/>
            <property name="Graph1.Graph1_HRP2JRL_gsensor_acceleration_2.attr" value="acceleration"/>
            <property name="Graph0.Graph0_HRP2JRL_lfsensor_force_2.attr" value="force"/>
        </item>
    <item
       class="com.generalrobotix.ui.item.GrxPythonScriptItem"
       name="hrp2_10-default.py"
       select="true"
       url="@CMAKE_INSTALL_PREFIX@/share/sot-openhrp/script/hrp2_10-default.py"/>
    <item
       class="com.generalrobotix.ui.item.GrxPythonScriptItem"
       name="abstract_experiment.py"
       select="false"
       url="@CMAKE_INSTALL_PREFIX@/share/sot-openhrp/script/abstract_experiment.py"/>

        <view class="com.generalrobotix.ui.view.GrxLoggerView" name="Logger View" select="false">
            <property name="showFrameRateSlider" value="true"/>
        </view>
        <view class="com.generalrobotix.ui.view.Grx3DView" name="3DView">
            <property name="corbaServer" value="true"/>
            <property name="view.eye" value="2.0 2.0 0.8"/>
            <property name="view.upward" value="0.0 0.0 1.0"/>
            <property name="view.lookat" value="0.0 0.0 0.8"/>
        </view>
    </mode>

    <mode name="Robot">
		<property name="robotHost" value="hrp2010c"/>
		<property name="robotPort" value="2809"/>
		<property name="ROBOT"     value="HRP2JRL"/>
        <view class="com.generalrobotix.ui.hrpsys.GrxIOBClientView" name="IOBClient" select="false">
            <property name="interval" value="200"/>
            <property name="setupFile" value="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/script/setup.py"/>
        </view>
		<item class="com.generalrobotix.ui.item.GrxWorldStateItem" name="untitled" select="true" url="">
            <property name="useDisk" value="false"/>
		</item>
        <item class="com.generalrobotix.ui.item.GrxModelItem" name="HRP2JRL" select="true" url="$(OPENHRPHOME)/Controller/IOserver/robot/HRP2JRL/model/HRP2JRLBush_main.wrl">
            <property name="isRobot" value="true"/>
            <property name="WAIST.translation" value="0 -0.0028 0.694"/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxModelItem" name="floor" select="false" url="$(OPENHRPHOME)/etc/longfloor.wrl">
            <property name="isRobot" value="false"/>
            <property name="WAIST.rotation" value="0.0 1.0 0.0 0.0 "/>
            <property name="WAIST.translation" value="0.0 0.0 -0.1 "/>
        </item>
        <item class="com.generalrobotix.ui.item.GrxCollisionPairItem" name="CP#floor#HRP2JRL" select="false" url="">
            <property name="objectName2" value="HRP2JRL"/>
            <property name="objectName1" value="floor"/>
            <property name="jointName2" value=""/>
            <property name="jointName1" value=""/>
            <property name="staticFriction" value="0.5"/>
            <property name="slidingFriction" value="0.5"/>
        </item>
    <item
       class="com.generalrobotix.ui.item.GrxPythonScriptItem"
       name="hrp2_10-default.py"
       select="true"
       url="@CMAKE_INSTALL_PREFIX@/share/sot-openhrp/script/hrp2_10-default.py"/>
    <item
       class="com.generalrobotix.ui.item.GrxPythonScriptItem"
       name="abstract_experiment.py"
       select="false"
       url="@CMAKE_INSTALL_PREFIX@/share/sot-openhrp/script/abstract_experiment.py"/>
    	<view class="com.generalrobotix.ui.view.Grx3DView" name="3DView">
			<property name="view.eye" value="2.0 2.0 0.8"/>
            <property name="view.lookat" value="0.0 0.0 0.8"/>
            <property name="view.upward" value="0.0 0.0 1.0"/>
		</view>
    </mode>
</grxui>
