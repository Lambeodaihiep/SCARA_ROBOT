function [Ed,dEd]=Quydaoduongthang(point1, point2, step)
    Ed = [];
    dEd = [];
    % Phương trình đường thẳng
    % x = x0 + a*t
    % y = y0 + b*t
    % z = z0 + c*t
    % (x0, y0, z0) là điểm mà ta muốn robot bắt đầu
    a = point2(1) - point1(1);
    b = point2(2) - point1(2);
    c = point2(3) - point1(3);
    for t = 0:1/step:1
        Ed(1, end+1)=point1(1) + a*t;
        Ed(2, end)=point1(2) + b*t;
        Ed(3, end)=point1(3) + c*t;
        
        dEd(1, end+1)=a;
        dEd(2, end)=b;
        dEd(3, end)=c;
        
    end

end