clc 
clear

%%%%%%% Parameter
[L1,L2,L3,L4]=parameter();

%%%%%%% Vi tri ban dau 
xx_0 = L2;
yy_0 = L3+L4;
zz_0 = L1;
E_0 = [xx_0;yy_0;zz_0];

%%%%%% Gia tri gan dung gop khop ban dau 
q1_0 = 0;
q2_0 = 0;
q3_0 = pi/2;
q4_0 = 0;

%%%%%% Tinh chinh xac goc khop ban dau 
for n=1:1:10^10
    Jnd_0=TinhJnd(q1_0,q2_0,q3_0,q4_0);
    [xE_0,yE_0,zE_0]=Donghocthuan(q1_0,q2_0,q3_0,q4_0);
    EE_0=[xE_0;yE_0;zE_0];
    delta_q_0=Jnd_0*(E_0 - EE_0);
    %tinh lai goc khop
    q1_0 = q1_0 + delta_q_0(1,1);
    q2_0 = q2_0 + delta_q_0(2,1);
    q3_0 = q3_0 + delta_q_0(3,1);
    q4_0 = q4_0 + delta_q_0(4,1);
    %%%% Do chinh xac 
    ss = 10^(-5);
    if abs(delta_q_0(1,1)) < ss
        if abs(delta_q_0(2,1)) < ss
            if abs(delta_q_0(3,1)) < ss
                if abs(delta_q_0(4,1)) < ss
                    break
                end
            end
        end
    end
    n;
end

%%%%% Xac nhan lai q_0
q1=q1_0;
q2=q2_0;
q3=q3_0;
q4=q4_0;

%%%%% 
dt = pi/50;
t_max = 0.63*pi;

d_dist = 0.1;
dist_max = 1;

for t=0:dt:t_max
    [Ed,dEd]=Quydao(t);
    Jnd=TinhJnd(q1,q2,q3,q4);
    dE=[dEd(1);dEd(2);dEd(3)];
    q=[q1;q2;q3;q4];
    dq=Jnd*dE; %van toc khop
    for k=1:1:10^5
        q_k=q + dq*dt;
        q1=q_k(1,1);
        q2=q_k(2,1);
        q3=q_k(3,1);
        q4=q_k(4,1);
        Jnd_real=TinhJnd(q1,q2,q3,q4);
        [xE,yE,zE]=Donghocthuan(q1,q2,q3,q4);
        Eq=[xE;yE;zE];
        [Ed,dEd]=Quydao(t);
        Em=[Ed(1);Ed(2);Ed(3)];
        Delta_q = Jnd_real*(Em-Eq);
        
        %%%%do chinh xax 
        ss1 = 10^(-5);
        if abs(Delta_q(1,1)) < ss1
            if abs(Delta_q(2,1)) < ss1
                if abs(Delta_q(3,1)) < ss1
                    if abs(Delta_q(4,1)) < ss1
                        break
                    end
                end
            end
        end
    end
    k;
    
    %%%%% Goc khop chinh xac 
    q1 = q1 + Delta_q(1,1);
    q2 = q2 + Delta_q(2,1);
    q3 = q3 + Delta_q(3,1);
    q4 = q4 + Delta_q(4,1);
    
    %%%%%% Quy dao 
    [xE_lai,yE_lai,zE_lai]=Donghocthuan(q1,q2,q3,q4);
    
    
    %%%% Bieu dien chuyen dong 
    P1 = [0 0 0];
    
    %%% Mo phong quy dao 
    
    curve=animatedline('Linewidth',1.5);
    set(gca,'xlim',[-(L2+L3+L4) (L2+L3+L4)],'Ylim',[-(L2+L3+L4) (L2+L3+L4)],'Zlim',[-L1/2 5*L1/3]);
    xlabel('X(m)');
    ylabel('Y(m)');
    zlabel('Z(m)');
    
    for t_q = 0:d_dist:dist_max
        % diem O
        x1=0;
        y1=0;
        z1=0;

        % diem A
        xA=0;
        yA=0;
        zA=L1+q2*t_q;
        
        xOA = 0;
        yOA = 0;
        zOA = L1+q2;

        % diem B
        xB = L2 * cos(q1) * t_q;
        yB = L2 * sin(q1) * t_q;
        zB = L1+q2 * t_q;
        
        xOB = L2 * cos(q1);
        yOB = L2 * sin(q1);
        zOB = L1+q2;

        % diem C
        xC = (cos(q1)*L3*cos(q3) - sin(q1)*L3*sin(q3)) * t_q + xOB;
        yC = (sin(q1)*L3*cos(q3) + cos(q1)*L3*sin(q3)) * t_q + yOB;
        zC = L1+q2 * t_q;
        
        xOC = cos(q1)*L3*cos(q3) - sin(q1)*L3*sin(q3) + L2 * cos(q1);
        yOC = sin(q1)*L3*cos(q3) + cos(q1)*L3*sin(q3) + L2 * sin(q1);
        zOC = L1+q2;
        
        % Visualization
        plot3(x1,y1,z1,'b.',0,0,0,'r.',xA,yA,zA,'g.',xOA,yOA,zOA,'r.',xB,yB,zB,'c.',xOB,yOB,zOB,'r.',xC,yC,zC,'b.',xOC,yOC,zOC,'r.')
        grid on
        hold on
    end

    %diem E 
    for t_q5 = 0:d_dist:dist_max
        % diem E
        xE = ((cos(q1) * cos(q3) - sin(q1) * sin(q3)) * L4 * cos(q4) + (-cos(q1) * sin(q3) - sin(q1) * cos(q3)) * L4 * sin(q4))*t_q5 + xOC;
        yE = ((sin(q1) * cos(q3) + cos(q1) * sin(q3)) * L4 * cos(q4) + (cos(q1) * cos(q3) - sin(q1) * sin(q3)) * L4 * sin(q4))*t_q5 + yOC;
        zE = L1+q2 * t_q5;
        
        [xOE,yOE,zOE]=Donghocthuan(q1,q2,q3,q4);
        plot3(xE,yE,zE,'y.',xOE,yOE,zOE,'r.')
        grid on
        hold on
    end
    
   pause(0.05)
       grid on
         hold on
end
        
        
        
        
        
        
    