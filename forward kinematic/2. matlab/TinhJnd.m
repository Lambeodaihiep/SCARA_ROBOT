function Jnd=TinhJnd(q1,q2,q3,q4)
[L1,L2,L3,L4]=parameter();
%% jacobian

J11=((-L4 * cos(q4) - L3) * cos(q3) + sin(q3) * sin(q4) * L4 - L2) * sin(q1) - (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3)) * cos(q1);
J12=0;
J13=(-sin(q4) * L4 * cos(q3) - sin(q3) * (L4 * cos(q4) + L3)) * cos(q1) - ((L4 * cos(q4) + L3) * cos(q3) - sin(q3) * sin(q4) * L4) * sin(q1);
J14=-((sin(q1) * cos(q3) + cos(q1) * sin(q3)) * cos(q4) + (cos(q1) * cos(q3) - sin(q1) * sin(q3)) * sin(q4)) * L4;

J21=((L4 * cos(q4) + L3) * cos(q3) - sin(q3) * sin(q4) * L4 + L2) * cos(q1) - (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3)) * sin(q1);
J22=0;
J23=((L4 * cos(q4) + L3) * cos(q3) - sin(q3) * sin(q4) * L4) * cos(q1) - (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3)) * sin(q1);
J24=-((sin(q1) * cos(q3) + cos(q1) * sin(q3)) * sin(q4) - (cos(q1) * cos(q3) - sin(q1) * sin(q3)) * cos(q4)) * L4;

J31=0;
J32=1;
J33=0;
J34=0;

J=[J11 J12 J13 J14; J21 J22 J23 J24; J31 J32 J33 J34];

%% chuyen vi jacobian
Jt=J';
%% Jacobi tua nghich dao
Jnd=(Jt*inv(J*Jt));
end