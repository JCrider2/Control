clear
clc
close all

% From Exercise 1.2
P.A = [-0.038 18.984 0 -32.174;
    -0.001 -0.632 1 0;
    0 -0.759 -0.518 0;
    0 0 1 0];
% State inputs V a q 0

P.B = [10.1 0;
    0 -0.0086;
    0.025 -0.011;
    0 0];
% Control inputs dth de

P.C = [1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];

P.D = [0 0;
    0 0;
    0 0;
    0 0];
pplane = ss(P.A,P.B,P.C,P.D);
plane.StateName = {'Velocity (m/s)';'angle of attack (rad)';
    'pitch angle rate (rad/s)';'pitch angle (rad)'};
plane.InputName = {'r';'fs'};
plane.OutputName = {'xb','sd','ab'};

ActNom = tf(1,[1/60 1]);
ActNom.InputName = 'u';
ActNom.OutputName = 'fs';





wc = 2;
t = 1/(2*3.141592653*wc);
K = 0.5/t;

[S.A, S.B, S.C, S.D] = tf2ss([K*t K],[1 0]);

Wc = 0.1;
Cc = 0.1;
 
k = 0.1;
tn = 5;
td = 0.005*t;
Wt = tf([k*tn k],[td 1]);

[T.A, T.B, T.C, T.D] = tf2ss([k*tn k],[td 1]);

D.A = [P.A [0;0;0;0] [0;0;0;0];
    -S.B.*P.C [S.A;S.A;S.A;S.A] [0;0;0;0];
   T.B*P.C [0;0;0;0] [T.A;T.A;T.A;T.A]];

D.B = [P.B;-S.B*P.D;T.B*P.D];
D.E = [0;S.B;0];
D.C =[-S.D*P.C [S.C;S.C;S.C;S.C]*[1 1 1 1] [0;0;0;0]*[0 0 0 0];
    T.D*P.C [0;0;0;0]*[1 1 1 1] [T.C;T.C;T.C;T.C]*[1 1 1 1];
    Wc*Cc*P.A [0;0;0;0]*[1 1 1 1] [0;0;0;0]*[1 1 1 1]];

D.D1 = [-S.D*P.D;
    T.D*P.D;
    Wc*Cc*P.B];
D.D2 = [S.D*[1;1;1;1];0*[1;1;1;1];0*[1;1;1;1]];

gamma = 5;
I = eye(12);
s = [D.C'*D.D1 D.C'*D.D2];

r = [D.D1'*D.D1 D.D1'*D.D2;
    D.D2'*D.D1 D.D2'*D.D2-gamma];
