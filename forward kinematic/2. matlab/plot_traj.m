[L1,L2,L3,L4]=parameter();
for t = 0:pi/100:0.63*pi
    x=L2+L3+L4-t;
    y=t;
    z=L1;

    plot3(x,y,z,'g.')
    grid on
    hold on
end