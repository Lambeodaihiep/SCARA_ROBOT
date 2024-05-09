function [Ed,dEd]=Quydao(t)
    [L1,L2,L3,L4]=parameter();
    Ed(1)=L2+80*sin(pi*t);
    Ed(2)=L3+L4+80*cos(pi*t);
    Ed(3)=L1;
    
    dEd(1)=80*pi*cos(pi*t);
    dEd(2)=-80*pi*sin(pi*t);
    dEd(3)=0;

end