new DynamicHrp2 dynmc
dynmc.setFiles ${HRP2_MODEL_DIRECTORY}/ HRP2JRLmainsmall.wrl ${HRP2_CONFIG_DIRECTORY}/HRP2Specificities.xml ${HRP2_CONFIG_DIRECTORY}/HRP2LinkJointRankSmall.xml
dynmc.parse

new Stack<vector> mcsmall
set mcsmall.in1 [6](0,0,0,0,0,0)
mcsmall.selec1 0 6
mcsmall.selec2 0 30
plug OpenHRP.motorcontrol mcsmall.in2

plug mcsmall.out dynmc.position
plug ffpos_from_pg.out dynmc.ffposition
plug zero.out dynmc.velocity
plug zero.out dynmc.acceleration

dynmc.createOpPoint 0 22
dynmc.createOpPoint lh 29

proc show0
-> get dyn.0
-> get dynmc.0
endproc

OpenHRP.periodicCall addSignal dyn.0
OpenHRP.periodicCall addSignal dynmc.0

OpenHRP.periodicCall addSignal dyn.lh
OpenHRP.periodicCall addSignal dynmc.lh
