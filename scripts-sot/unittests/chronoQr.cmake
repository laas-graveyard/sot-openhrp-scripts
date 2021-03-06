import simusmall

set taskCom.controlGain 10


loadPlugin sot-qr.so
new SOTQr sotqr
sotqr.nbJoints 36
sotqr.push task
sotqr.push taskTwofeet
sotqr.push taskCom

new SOT sotsvd
sotsvd.nbJoints 36
sotsvd.push task
sotsvd.push taskTwofeet
sotsvd.push taskCom


compute task.task
compute task.jacobian
compute taskCom.task
compute taskCom.jacobian
compute taskTwofeet.task
compute taskTwofeet.jacobian

compute sotsvd.constraint
compute sotqr.constraint

proc test $i
-> compute task.task  $i
-> compute task.jacobian $i
-> compute taskCom.task $i
-> compute taskCom.jacobian $i
-> compute taskTwofeet.task $i
-> compute taskTwofeet.jacobian $i
-> chrono compute sotsvd.control $i
-> chrono compute sotqr.control $i
-> OpenHRP.inc
-> echo --- --- --- --- --- --- ---
endproc

for i=1:100 test i





