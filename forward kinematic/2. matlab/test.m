clear

x = serialport('COM8',9600);
%%fopen(x);
% 0;0;90;0;1!
msg1 = "0;0;90;0;1!";
msg2 = "0;0;0;0;1!";
msg3 = "0;0;-90;0;1!";
go = true;
while go
    a = input('nhap: ');
    %%fprintf(x,a);
    %%fscanf(x)
    if (a == 1)
        write(x,msg1,"string")
%         read(x,27,"string")
    end
    if (a == 2)
        write(x,msg2,"string")
    end
    if (a == 3)
        write(x,msg3,"string")
    end
    if (a == -1) 
        go = false;
    end
end

%%fclose(x);
clear
