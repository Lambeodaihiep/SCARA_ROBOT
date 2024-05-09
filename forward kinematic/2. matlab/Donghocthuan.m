function[xE,yE,zE]=Donghocthuan(q1,q2,q3,q4)
[L1,L2,L3,L4]=parameter;
xE = (cos(q1) * cos(q3) - sin(q1) * sin(q3)) * L4 * cos(q4) + (-cos(q1) * sin(q3) - sin(q1) * cos(q3)) * L4 * sin(q4) + cos(q1) * L3 * cos(q3) - sin(q1) * L3 * sin(q3) + cos(q1) * L2;
yE = (sin(q1) * cos(q3) + cos(q1) * sin(q3)) * L4 * cos(q4) + (cos(q1) * cos(q3) - sin(q1) * sin(q3)) * L4 * sin(q4) + sin(q1) * L3 * cos(q3) + cos(q1) * L3 * sin(q3) + sin(q1) * L2;
zE = q2+L1;
end