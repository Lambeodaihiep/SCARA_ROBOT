function [Ed,dEd]=Quydaoduongtron(t, scale, radius)
    Ed = [];
    dEd = [];
    [L1,L2,L3,L4]=parameter();
    for i = 0:t/scale:t
        Ed(1, end+1)=L2+(L3+L4)/2+radius*sin(pi*i);
        Ed(2, end)=L4+radius*cos(pi*i);
        Ed(3, end)=L1;
        
        dEd(1, end+1)=radius*pi*cos(pi*i);
        dEd(2, end)=-radius*pi*sin(pi*i);
        dEd(3, end)=0;
    end

end