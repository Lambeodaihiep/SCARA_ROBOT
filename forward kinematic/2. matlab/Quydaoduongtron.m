function [Ed,dEd]=Quydaoduongtron(center, radius, height, step)
    Ed = [];
    dEd = [];
    for i = 0:0.63*pi/step:0.63*pi
        Ed(1, end+1)=center(1) + radius*sin(pi*i);
        Ed(2, end)=center(2) + radius*cos(pi*i);
        Ed(3, end)=height;
        
        dEd(1, end+1)=radius*pi*cos(pi*i);
        dEd(2, end)=-radius*pi*sin(pi*i);
        dEd(3, end)=0;
    end

end