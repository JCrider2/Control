% P.A = [0 0 1 0;
%     0.0487 -0.0829 0 -1;
%     0 -4.546 -1.699 0.1717;
%     0 3.382 -0.0654 -0.0893];
% P.B = [0 0;0 0.0116;27.276 0.5758;0.3952 -1.362];
% P.C = eye(4);
% P.D = [0 0;0 0;0 0;0 0];
% plane = ss(P.A,P.B,P.C,P.D);
% plane.StateName = {'Roll Angle (rad)';'Side Slip Angle (rad)';
%     'Roll Rate (rad/s)';'Yaw rate (rad/s)'};
% plane.InputName = {'dA';'dR'};
% plane.OutputName = {}
% 
% tzero(plane({}))

za = -1.05273;
zd = -0.0343;
ma = -2.3294;
mq = -1.03341;
md = -1.1684;
V = 329.127;
wa = 6.283*13;
dd = 0.6;

Wc = 0.1;
Cc = 1;
S.A = 0;
S.B = 1;
S.C = 6.283;
S.D = 0.5;

T.A = -200;
T.B = 1;
T.C = -2109.1;
T.D = 11.252;

p.A = [za V*za 0 V*zd;
    ma/(V*za) mq (md-ma*zd/za) 0;
    0 0 0 1;
    0 0 -wa^2 -2*dd*wa];
p.B = [0;0;0;wa^2];

p.C = eye(4);
p.D = [0;0;0;0];

d.A = [p.A [0;0;0;0] [0;0;0;0];
    -S.B*p.C S.A*[1;1;1;1] [0;0;0;0];
    T.B*p.C [0;0;0;0] T.A*[1;1;1;1]];

d.B = [p.B; -S.B*p.D; T.B*p.D];

d.E = [[0 0 0 0].*[0;0;0;0]; [1;1;1;1].*[1 1 1 1]*S.B; [0 0 0 0].*[1;1;1;1]];

d.C = [-S.D*p.C [1;1;1;1]*S.C [0;0;0;0];
    T.D*p.C [0;0;0;0] T.C*[1;1;1;1];
    Wc*Cc*p.A [0;0;0;0] [0;0;0;0]];

d.D1 = [-S.D*p.D;
    T.D*p.D;
    Wc*Cc*p.B];

d.D2 = [S.D*[1;1;1;1];[0;0;0;0];[0;0;0;0]];


s = [d.C'*d.D1 d.C'*d.D2];

r = [d.D1'*d.D1 d.D1'*d.D2; d.D2'*d.D1 d.D2'*d.D2];

