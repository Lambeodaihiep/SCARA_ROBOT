[L1,L2,L3,L4]=parameter();
for t = 0:pi/50:pi
    x=L2+L3+L4+20*sin(pi*t);
    y=20*cos(pi*t);
    z=L1;

    plot3(x,y,z,'g.')
    grid on
    hold on
end