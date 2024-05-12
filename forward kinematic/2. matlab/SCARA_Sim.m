disp("SCARA Manipulator");
syms LL1 LL2 LL3 LL4 q1 q2 q3 q4

%% Links length
[L1, L2, L3, L4] = parameter();
LL1 = L1;
LL2 = L2;
LL3 = L3;
LL4 = L4;

%% DH parameters
H0_1 = Link([0, 0, 0, 0, 0, 0]);
H0_1.qlim = [-2*pi/3 2*pi/3];

H1_2 = Link([0, 0, L2, 0, 1, L1]);
H1_2.qlim = [0 200];

H2_3 = Link([0, 0, L3, 0, 0, 0]);
H2_3.qlim = [-2*pi/3 2*pi/3];

H3_E = Link([0, 0, L4, 0, 0, 0]);
H3_E.qlim = [-2*pi/3 2*pi/3];

SCARA = SerialLink([H0_1 H1_2 H2_3 H3_E], "name", "SCARA");
% SCARA.teach
% for i = 0:pi/2/50:pi/2
%     SCARA.plot([i 0 -i i/2], "workspace", [-2*(L2+L3+L4) 2*L2+L3+L4 -2*(L2+L3+L4) 2*L2+L3+L4 -20 6*L1]);
% end

init_q = [0 0 0 0];
[Ed,dEd]=Quydaoduongthang(200, 100);
plot3(Ed(1,:), Ed(2,:), Ed(3,:), 'g.');
hold on
for i = 1:1:length(Ed)
    obj = transl(Ed(:,i)) *...
    rpy2tr(0, 0, 0);
    q = SCARA.ikine(obj , [init_q 0 0], 'mask', [1 1 1 1 0 0]);
    init_q = q;
    SCARA.plot(q, "workspace", [-2*(L2+L3+L4) 2*L2+L3+L4 -2*(L2+L3+L4) 2*L2+L3+L4 -20 6*L1]);
end
