for t = 0:pi/50:pi
    x=0.5+30*sin(pi*t); %m
    y=0.2+30*cos(pi*t); %m
    z=1; %m

    plot3(x,y,z,'g.')
    grid on
    hold on
end