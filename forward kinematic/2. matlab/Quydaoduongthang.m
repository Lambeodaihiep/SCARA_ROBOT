function [Ed,dEd]=Quydaoduongthang(t, scale)
    Ed = [];
    dEd = [];
    [L1,L2,L3,L4]=parameter();
    for i = 0:t/scale:t
        Ed(1, end+1)=L2+L3+L4-i;
        Ed(2, end)=i;
        Ed(3, end)=L1;
        
        dEd(1, end+1)=-1;
        dEd(2, end)=1;
        dEd(3, end)=0;
    end

end