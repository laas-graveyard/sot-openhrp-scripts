loadPlugin repro-constraints${DYN_LIB_EXT} ${CMAKE_INSTALL_PREFIX}/lib/plugin
loadPlugin task-learning${DYN_LIB_EXT} ${CMAKE_INSTALL_PREFIX}/lib/plugin

new ReproConstraints freezer
new TaskLearning tlearn


# --- PLUG ---
# --- PLUG ---
# --- PLUG ---

plug fsensor.out freezer.forceIN
plug wrtPoseInitQuat.out freezer.positionIN
plug vrh.out freezer.velocityIN

plug freezer.freeze tlearn.freezeIN
plug fsensor.out tlearn.forceIN
plug wrtPoseInitQuat.out tlearn.positionIN
plug vrh.out tlearn.velocityIN

OpenHRP.periodicCall addSignal freezer.freeze


# --- PARAMS ---
# --- PARAMS ---
# --- PARAMS ---

tlearn.beta 0.03
tlearn.dt 0.005
tlearn.mode kinematic
tlearn.file /tmp/model_Follower_Leader_kinematics.txt
tlearn.nIterMax 1000


# ---
# --- conversion of the velocity output from world coordinates
# to hand coordinates ---
# Make use of Vw, declared in script teleoperation/teleopAll
# ---

new Multiply<vector,matrix> reflearn
plug tlearn.velocity reflearn.in1
plug Vw.out reflearn.in2


# --- HAND ORIENTATION --- #
# --- HAND ORIENTATION --- #
# --- HAND ORIENTATION --- #


# new FeaturePoint6d o6
# new FeaturePoint6d o6d
#
# # comp is declared in dyn
# plug comp.out o6d.position
# plug dyn.J0 o6.Jq
# plug dyn.0 o6.position
# set o6.sdes o6d
#
# new Task taskRhand
# taskRhand.add o6
# new GainAdaptive gainRhand
# gainRhand.setConstant .2
# plug taskRhand.error gainRhand.error
# plug gainRhand.gain taskRhand.controlGain
#
# set o6.selec 111000
# o6.frame current


# --- POS INIT TASK --- #
# --- POS INIT TASK --- #
# --- POS INIT TASK --- #


plug poseInit.in p6d.position

set tlearn.freezeIN 0

# --- FUNCTIONS ---
# --- FUNCTIONS ---
# --- FUNCTIONS ---


proc repro(enable)
-> plug reflearn.out p3.errorIN
-> plug reflearn.out p3LH.errorIN
endproc

# Use this function to compute the reference at each timestep
# then in the shell, call tlearn.velocity or reflearn.out
# to see the value of the the computed velocity reference.
proc repro(eval)
-> OpenHRP.periodicCall addSignal reflearn.out
endproc

proc learntr
-> tr.clear
-> tr.add tlearn.velocity vref_world
-> tr.add wrtPoseInitQuat.out pos_world
-> tr.add fsensor.out force_world
-> tr.add freezer.freeze
endproc

proc learnscripts
-> import tlearn
-> import taskLearning/taskLearning
endproc

proc learnkin
-> tlearn.file /tmp/model_Follower_Leader_kinematics.txt
-> tlearn.mode kinematic
-> tlearn.beta 0.3
-> tlearn.nIterMax 2000
endproc

proc learncomplete
-> tlearn.file /tmp/model_Follower_Leader.txt
-> tlearn.mode complete
-> tlearn.beta 0.03
-> tlearn.nIterMax 1000
endproc

proc learnsimu
-> set forceCompRH.torsorNullified [6](0,0,0,0,0,0)
endproc

proc learnzerohands
-> plug dyn.0 poseInit.in
-> compute poseInit.out
-> freeze poseInit.in
endproc

proc learninit
-> sot.push taskChest
-> sot.push taskRhand
-> sot.push taskGrip
-> sot.push task
endproc

proc learnstart
-> sot.rm task
-> sot.push taskForce
-> tr.start
-> repro(enable)
-> tlearn.start
endproc

proc learnsave
-> tr.trace
endproc

proc learnstop
-> tr.stop
-> plug forceInt.velocity p3.errorIN
-> plug forceIntLH.velocity p3LH.errorIN
endproc

proc learnback
-> sot.rm taskForce
-> sot.push task
endproc

# typically:
# learntr
# learnkin
# learnsimu
# learnstart
# learnstop


OpenHRP.periodicCall addSignal tlearn.run

