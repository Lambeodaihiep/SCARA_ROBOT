for t = 0:pi/100:0.63*pi
    x=20*sin(pi*t); %m
    y=20*cos(pi*t); %m
    z=1; %m

    plot3(x,y,z,'g.')
    grid on
    hold on
end