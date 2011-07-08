#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
# Copyright (C) 2010 Franï¿œois Bleibel, Thomas Moulard, JRL, CNRS/AIST.
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

import os, sys, time

# Make sure the OpenHRP Python modules are found.
hrp2_script_dir='/opt/grx3.0/HRP2JRL/script'
sys.path.append(hrp2_script_dir)
hrp2_script_dir='/opt/grx3.0/HRP2LAAS/script'
sys.path.append(hrp2_script_dir)


# HRP-2 specific
import hrp
import hstsetup

# Robots.
class Hrp2_10:
    pass

class Hrp2_14:
    pass

robots = [Hrp2_10, Hrp2_14]

class InitialPosition(object):
    """
    This class defines the robot starting position.
    It defines the position of:
    - the left and right lefts
    - the left and right arms
    - the left and right hands
    - the chest
    - the head

    An initial position is required to instantiate an experiment.
    """
    def __init__(self, lleg, rleg, chest, head, larm, rarm, lhand, rhand):
        self.lleg = lleg
        self.rleg = rleg
        self.chest = chest
        self.head = head
        self.larm = larm
        self.rarm = rarm
        self.lhand = lhand
        self.rhand = rhand

defaultInitialPositions = {
    Hrp2_10:
    InitialPosition(
        "0 0 -26 50 -24 0",
        "0 0 -26 50 -24 0",
        "0 0",
        "0 0",
        "15  10 0 -30 0 0 0 10",
        "15 -10 0 -30 0 0 0 10",
        "-10.0 10.0 -10.0 10.0 -10.0",
        "-10.0 10.0 -10.0 10.0 -10.0"),

    Hrp2_14:
    InitialPosition(
        "0 0 -26 50 -24 0",
        "0 0 -26 50 -24 0",
        "0 0",
        "0 0",
        "15  10 0 -30 0 0 10",
        "15 -10 0 -30 0 0 10",
        "-10.0 10.0 -10.0 10.0 -10.0",
        "-10.0 10.0 -10.0 10.0 -10.0")
    }

# FIXME: find a ROBUST way to know what is the current robot.
class AbstractExperiment(object):
    """
    This class implements the initialization and destruction
    of the stack of tasks.

    It is recommended to inherit from this class to develop your own
    robotics application and by overriding the method implementation.
    """
    def __init__(self,
                 robot = Hrp2_14,
                 initialPositions = defaultInitialPositions):
        """
        The constructor takes two parameters:

        - the kind of robot used,
        - an initial position.
        """
        self.corba_string = "-ORBconfig../../../../../Common/orb.conf"
        self.GEOMETRIC_MODE = False

        self.robot = robot

        self.with_trace = True
        self.with_altitude = False
        self.with_teleop = False
        self.with_deadzone = False
        self.with_taskchest = True
        self.with_table = False
        self.with_posture = False
        self.with_collision = False
        self.with_homotopy = False
        self.with_joystick = False


        self.ms = hrp.findPluginManager("motionsys")

        # Kalman filter.
        if(not self.GEOMETRIC_MODE):
            self.ms.load("kfplugin")
            self.kf = self.ms.create("kfplugin","kf","")
            self.kf.start()

        # Sequence player.
        self.ms.load("seqplay")
        self.seq = hrp.SequencePlayerHelper.narrow(
            self.ms.create("seqplay","seq", self.corba_string))
        self.seq.start()

        # Stack of tasks.
	robot_string = ""
	if ( self.robot == Hrp2_10 ):
            robot_string = "HRP2JRL10Small"

        self.ms.load("StackOfTasks")
        self.SoT = self.ms.create("StackOfTasks","SoT",robot_string)

        if(not self.GEOMETRIC_MODE):
            self.ms.load("hstabilizer")
            self.st = self.ms.create("hstabilizer","st","")

        # Log plugin.
        self.ms.load("logplugin")
        self.log = hrp.LoggerPluginHelper.narrow(
            self.ms.create("logplugin","log",""))
        if(not self.GEOMETRIC_MODE):
            self.log.add("kf")
            self.log.add("st")
            self.log.sendMsg(":max-length 80")
            self.log.start()

        # Specific to walking.
        if(not self.GEOMETRIC_MODE):
            hstsetup.stsetup(self.st)
            self.kf.start()
            self.st.start()

        self.seq.sendMsg(
            ":joint-angles "
            + initialPositions[robot].rleg
            + " "
            + initialPositions[robot].lleg
            + " "
            + initialPositions[robot].chest
            + " "
            + initialPositions[robot].head
            + " "
            + initialPositions[robot].rarm
            + " "
            + initialPositions[robot].larm
            + " "
            + initialPositions[robot].rhand
            + " "
            + initialPositions[robot].lhand
            + " 2.5")
        self.seq.waitInterpolation()

        # Initialize the SoT.
        self.SoT.sendMsg(":init")

        # Initialize the dynamics.
        if (self.robot == Hrp2_14):
            self.SoT.sendMsg(":script import dynsmall")
        elif (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import dynsmallpart1hrp2_10")
            self.SoT.sendMsg(":script import dynsmallpart2hrp2_10")
        else:
            print "Invalid robot. Aborting..."
            sys.exit(1)

        # Initialize CORBA.
        self.SoT.sendMsg(":script import coshell")

        # Initialize the tracer.
        self.SoT.sendMsg(":script import traces")

        # Plug OpenHRP signals.
        self.SoT.sendMsg(":script OpenHRP.refstate mc")
        self.SoT.sendMsg(":script plug OpenHRP.state dyn.position")
        self.SoT.sendMsg(":script plug OpenHRP.state dyn2.position")
        self.SoT.sendMsg(":script plug OpenHRP.attitude posKF.attitudeIN")
        self.SoT.sendMsg(
            ":script plug OpenHRP.attitude flex.sensorWorldRotation")
        self.SoT.sendMsg(":script plug sot.control OpenHRP.control")

        # FIXME: what is this?
        if (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import smallhrp2_10")
        elif (self.robot == Hrp2_14):
            self.SoT.sendMsg(":script import small")
        else:
            print "Invalid robot. Aborting..."
            sys.exit(1)

        if (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import jointlimit")


        # Manipulation.
        self.SoT.sendMsg(":script OpenHRP.pause")
        self.SoT.start()

        if (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import forcehrp2_10")
            self.SoT.sendMsg(":script import forceLhrp2_10")
        elif (self.robot == Hrp2_14):
            self.SoT.sendMsg(":script import force")
            self.SoT.sendMsg(":script import forceL")
        else:
            print "Invalid robot. Aborting..."
            sys.exit(1)

        self.SoT.sendMsg(":script import grip")

        # Teleop.
        if (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import teleoperation/teleophrp2_10")
        elif (self.robot == Hrp2_14):
            self.SoT.sendMsg(":script import teleoperation/teleop")
        else:
            print "Invalid robot. Aborting..."
            sys.exit(1)

        self.SoT.sendMsg(":script sot.clear")

        # Pattern generator.
        if (self.robot == Hrp2_10):
            self.SoT.sendMsg(":script import hwpgpginitpart1hrp2_10")
        elif (self.robot == Hrp2_14):
            self.SoT.sendMsg(":script import hwpgpginitpart1")
        else:
            print "Invalid robot. Aborting..."
            sys.exit(1)
        self.SoT.sendMsg(":script import hwpgpginitpart2")


        # FIXME: what is this?
        time.sleep(1)
        self.SoT.sendMsg(":script import hwpginitframes")
        self.SoT.sendMsg(":script plug lfo_H_wa.out OpenHRP.positionIN")

        # Reactive Walk.
        if(not self.with_joystick):
            self.SoT.sendMsg(":script import walkreact-new")
        else:
            self.SoT.sendMsg(":script import walkreact-joystick")
        self.SoT.sendMsg(":script import walking/hwpgfeettasksrel")

        # Play.
        self.SoT.sendMsg(":script OpenHRP.reinit from mc")
        self.SoT.sendMsg(":script OpenHRP.play")

        if(self.with_trace):
            self.SoT.sendMsg(":script tr.start")

        # Misc.
        self.SoT.sendMsg(":script import clamp-workspace")
        if(self.with_altitude):
                self.SoT.sendMsg(":script import handsAltitude")
        if(self.with_posture):
            if (self.robot == Hrp2_10):
                self.SoT.sendMsg(":script import taskPosturehrp2_10")
            elif (self.robot == Hrp2_14):
                self.SoT.sendMsg(":script import taskPosture")
            else:
                print "Invalid robot. Aborting..."
                sys.exit(1)

        if(self.with_collision):
            self.SoT.sendMsg(":script import collisiondetection")

        # Ensure end-effector positions is computed properly.

        # This avoids a lot of troubles for tasks which record a
        # "zero" position! It often occured that the zero was not
        # properly computed because the update of dyn.0 and dyn.lh was
        # not asked by any entity - and the "compute enity.out"
        # doesn't seem to work.
        self.SoT.sendMsg(":script OpenHRP.periodicCall addSignal dyn.0")
        self.SoT.sendMsg(":script OpenHRP.periodicCall addSignal dyn.lh")
        self.SoT.sendMsg(":script OpenHRP.periodicCall addSignal dyn2.0")
        self.SoT.sendMsg(":script OpenHRP.periodicCall addSignal dyn2.lh")

        time.sleep(1)

        # Tasks.
        self.SoT.sendMsg(":script sot.clear")
        if(self.with_taskchest):
            self.SoT.sendMsg(":script sot.push taskLeftArm")
            self.SoT.sendMsg(":script sot.push taskRightArm")
	    self.SoT.sendMsg(":script sot.push taskChest")

        self.SoT.sendMsg(":script sot.push taskTwofeet")
        self.SoT.sendMsg(":script sot.push taskWaist")

        if(self.with_altitude):
            self.SoT.sendMsg(":script zeroaltitude")
            self.SoT.sendMsg(":script sot.push taskRhand")
            self.SoT.sendMsg(":script sot.push taskLhand")

        self.SoT.sendMsg(":script sot.push taskComPD")


    def __str__(self):
        return "abstract experiment"

    def stopExperiment(self):
        print "stopping the experiment"
        self.SoT.sendMsg(":hold")

        # Careful! The SOT plugin should not be stopped before seqplay
        # has ended its motion. waitInterpolation should block the
        # script. If not, don't push [OK] to the next dialog box
        # before the robot has reached the 1/2seating.
        if(self.with_trace):
            self.SoT.sendMsg(":script tr.trace")
        self.SoT.sendMsg(":waitForFinished")
        self.SoT.stop()

        self.SoT.sendMsg(':profile')
        self.ms.sendMsg(":destroy SoT")
        self.ms.sendMsg(":unload StackOfTasks")

        # Logs.
        self.log.stop()
        self.log.save("WalkTask")

exp = None
def launchExperiment(Experiment):
    """
    Launch an experiment.

    The only argument of this function is the type of experiment that
    should be launched (type in the sense of the object-oriented
    programming paradigm).
    """
    global exp
    print "Initializing the experiment..."
    print "\tExperiment class = " + str(Experiment)

    exp = Experiment ()
    print "Initialization finished."
    waitInputMenu([[
                '------- Sequence ----------',
                '#label'
                ]])
    exp.stopStepper()
    exp.stopExperiment()
    print "Experiment has finished."

if __name__ == "main":
    launchExperiment(AbstractExperiment)
