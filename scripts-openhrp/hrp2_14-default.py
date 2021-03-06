#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
# Copyright (C) 2010 Fran�ois Bleibel, Thomas Moulard, JRL, CNRS/AIST.
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

from abstract_experiment import AbstractExperiment, launchExperiment
from abstract_experiment import Hrp2_10, Hrp2_14
from abstract_experiment import defaultInitialPositions
from abstract_experiment import exp

class Default(AbstractExperiment):
    def __init__(self,
                 robot = Hrp2_14,
                 initialPosition = defaultInitialPositions):
        AbstractExperiment.__init__(self, robot, initialPosition)

if __name__ == "main":
    launchExperiment(Default)
