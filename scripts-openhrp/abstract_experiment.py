#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
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

# HRP-2 specific
import hrp
import hstsetup

from hrp import *

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
    "hrp2_10":
    InitialPosition(
        "0 0 -26 50 -24 0",
        "0 0 -26 50 -24 0",
        "0 0",
        "0 0",
        "15  10 0 -30 0 0 0 10",
        "15 -10 0 -30 0 0 0 10",
        "-10.0 10.0 -10.0 10.0 -10.0",
        "-10.0 10.0 -10.0 10.0 -10.0"),

    "hrp2_10_small":
    InitialPosition(
        "0 0 -26 50 -24 0",
        "0 0 -26 50 -24 0",
        "0 0",
        "0 0",
        "15  10 0 -30 0 0 0 10",
        "15 -10 0 -30 0 0 0 10",
        "-10.0 10.0 -10.0 10.0 -10.0",
        "-10.0 10.0 -10.0 10.0 -10.0"),

    "hrp2_14":
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
    robotics application and implement your own launchExperiment method.
    """
    def __init__(self,
                 experiment_name = "abstract-experiment",
                 initialPosition = defaultInitialPosition["hrp2_10"]):
        """
        The constructor takes two parameters:

        - an experiment name which control what scripts will be executed
          when the experiment state is changing (i.e. at each transition,
          experiment/<experiment_name> will be imported),
        - an initial position.
        """
        self.corba_string = "-ORBconfig../../../../../Common/orb.conf"
        self.GEOMETRIC_MODE = False
        self.with_trace = False
        self.experiment_name = experiment_name

        self.ms = findPluginManager("motionsys")

        # Kalman filter.
        if(not self.GEOMETRIC_MODE):
            self.ms.load("kfplugin")
            self.kf = self.ms.create("kfplugin","kf","")
            self.kf.start()

        # Sequence player.
        self.ms.load("seqplay")
        self.seq = SequencePlayerHelper.narrow(
            self.ms.create("seqplay","seq", self.corba_string))
        self.seq.start()

        # Stack of tasks.
        self.ms.load("StackOfTasks")
        self.SoT = self.ms.create("StackOfTasks","SoT","")

        if(not self.GEOMETRIC_MODE):
            self.ms.load("hstabilizer")
            self.st = self.ms.create("hstabilizer","st","")

        # Log plugin.
        self.ms.load("logplugin")
        self.log = LoggerPluginHelper.narrow(
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
            + initialPosition.rleg
            + " "
            + initialPosition.lleg
            + " "
            + initialPosition.chest
            + " "
            + initialPosition.head
            + " "
            + initialPosition.rarm
            + " "
            + initialPosition.larm
            + " "
            + initialPosition.rhand
            + " "
            + initialPosition.lhand
            + " 2.5")
        self.seq.waitInterpolation()

        # Initialize the SoT.
        self.SoT.sendMsg(":init")

        # Launch the prologue.
        self.SoT.sendMsg(":script import " + prologue)

    def __str__(self):
        return "abstract experiment"

    def launchExperiment(self, extraActions = [[]]):
        waitInputMenu([[
                    '------- Sequence ----------',
                    '#label',

                    'StartExperiment',
                    'self.startExperiment()'

                    'StopExperiment',
                    'self.stopExperiment()'
                    ]] + extraActions)
        self.stopExperiment()

    def startExperiment(self):
        self.SoT.sendMsg(":script import experiment/"
                         + self.experiment_name + "-start")

    def stopExperiment(self):
        self.SoT.sendMsg(":script import experiment/"
                         + self.experiment_name + "-stop")

def launchExperiment(Experiment):
    """
    Launch an experiment.

    The only argument of this function is the type of experiment that
    should be launched (type in the sense of the object-oriented
    programming paradigm).
    """
    print "Initializing the experiment..."
    print "\tExperiment class = " + str(Experiment)

    exp = Experiment ()
    print "Starting experiment..."
    exp.launchExperiment ()
    print "Experiment has finished."

if __name__ == "main":
    launchExperiment(AbstractExperiment)
