import simusmall
import traces

plug OpenHRP.state dyn.position
plug OpenHRP.state dyn2.position
plug OpenHRP.attitude posKF.attitudeIN
plug OpenHRP.attitude flex.sensorWorldRotation
plug sot.control OpenHRP.control

import force
import forceL
import small
import jointlimit
import grip

import teleoperation/teleop
sot.clear

import hwpgpginit
import hwpginitframes
import walkreact
import walking/hwpgfeettasksrel


sot.clear
sot.push taskForce
sot.push taskForceLH



tr.clear
tr.add Aact.out inertia_sot



set dyn.position [36](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set dyn2.position [36](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)


chrono OpenHRP.inc

tr.stop
tr.trace

