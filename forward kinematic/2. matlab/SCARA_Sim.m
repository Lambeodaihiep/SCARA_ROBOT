%% Links length
[L1, L2, L3, L4] = parameter();
LL1 = L1;
LL2 = L2;
LL3 = L3;
LL4 = L4;

%% DH parameters
H0_1 = Link([0, 0, 0, 0, 0, 0]);
H0_1.qlim = [-5*pi/6 5*pi/6];

H1_2 = Link([0, 0, L2, 0, 1, L1]);
H1_2.qlim = [0 200];

H2_3 = Link([0, 0, L3, 0, 0, 0]);
H2_3.qlim = [-5*pi/6 5*pi/6];

H3_E = Link([0, 0, L4, 0, 0, 0]);
H3_E.qlim = [-pi/2 pi/2];


SCARA = SerialLink([H0_1 H1_2 H2_3 H3_E], "name", "SCARA");
% SCARA.teach
% for i = 0:pi/2/50:pi/2
%     SCARA.plot([i 0 -i i/2], "workspace", [-2*(L2+L3+L4) 2*L2+L3+L4 -2*(L2+L3+L4) 2*L2+L3+L4 -20 6*L1]);
% end

init_q = [0 0 0 0];
Q_real = [];
% [Ed,dEd]=Quydaoduongthang(200, 100);
[Ed,dEd]=Quydaoduongtron(0.63*pi, 50, 20);
plot3(Ed(1,:), Ed(2,:), Ed(3,:), 'r.');
hold on
for i = 1:1:length(Ed)
    obj = transl(Ed(:,i)) *...
    rpy2tr(0, 0, 0);
    q = SCARA.ikine(obj , [init_q 0 0], 'mask', [1 1 1 1 0 0]);
    Q_real(1,end+1) = q(1);
    Q_real(2,end) = q(2);
    Q_real(3,end) = q(3);
    Q_real(4,end) = q(4);
    init_q = q;
    SCARA.plot(q, "workspace", [-2*(L2+L3+L4) 2*L2+L3+L4 -2*(L2+L3+L4) 2*L2+L3+L4 -20 6*L1]);
end
