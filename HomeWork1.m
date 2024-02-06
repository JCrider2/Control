clear
clc
close all


Q = @(d,u) d*u.^2*0.5;
% Summary of Lateral directional derivatives
L_p = @(Q,S,b,C_lp,I_x,u) (Q*S*b.^2*C_lp)./(2*I_x*u);       % s^-1
L_b = @(Q,S,b,C_lb,I_x) (Q*S*b.^2*C_lb)./I_x;               % s^-1
L_r = @(Q,S,b,C_lr,I_x,u) (Q*S*b.^2*C_lr)./(2*I_x*u);       % s^-1
L_d_a = @(Q,S,b,C_lda,I_x) (Q*S*b*C_lda)./I_x;              % s^-2
L_d_r = @(Q,S,b,C_ldr,I_x) (Q*S*b*C_ldr)./I_x;              % s^-2
Y_b = @(Q,S,b,C_yb,m) (Q*S*C_yb)./m;                        % m/s^2
Y_p = @(Q,S,b,C_yp,m,u) (Q*S*C_yp)./(2*m*u);                % m/s
Y_r = @(Q,S,b,C_yr,m,u) (Q*S*C_yr)./(2*m*u);                % m/s
Y_d_a = @(Q,S,b,C_yda,m) (Q*S*C_yda)./m;                    % m/s^2
Y_d_r = @(Q,S,b,C_yda,m) (Q*S*C_ydr)./m;                    % m/s^2
N_b = @(Q,S,b,C_nb,I_z) (Q*S*b*C_nb)./I_z;                  % s^-2
N_p = @(Q,S,b,C_np,I_x,u) (Q*S*b.^2*C_np)./(2*I_x*u);       % s^-1
N_r = @(Q,S,b,C_nr,I_x,u) (Q*S*b.^2*C_nr)./(2*I_x*u);       % s^-1
N_d_a = @(Q,S,b,C_nda,I_z) (Q*S*b*C_nda)./I_z;              % s^-2
N_d_r = @(Q,S,b,C_nbr,I_z) (Q*S*b*C_nbr)./I_z;              % s^-2


u = linspace(50,200,7).*1.68781;
Nav_Q = Q(0.0023769,u);
Nav_S = 184;
Nav_b = 33.4;
Nav_Ix = 1048;
Nav_C = 5.7;
Sta_Q = Q(0.0023769,u);
Sta_S = 196.1;
Sta_b = 21.94;
Sta_Ix = 3549;
Sta_C = 9.55;

Navion_L_P = L_p(Nav_Q,Nav_S,Nav_b,-0.410,Nav_Ix,u);
Navion_L_d_a = L_d_a(Nav_Q,Nav_S,Nav_b,-0.134,Nav_Ix);

Star_L_P = L_p(Sta_Q,Sta_S,Sta_b,-0.285,Sta_Ix,u);
Star_L_d_a = L_d_a(Sta_Q,Sta_S,Sta_b,0.039,Sta_Ix);

subplot
figure(1)
plot(u,Navion_L_P)
hold on
plot(u,Navion_L_d_a)
title('Navion')
legend('Lp','Lda')
xlabel('velocity ft/s')

figure(2)
plot(u,Star_L_P)
hold on
plot(u,Star_L_d_a)
title('Star')
legend('Lp','Lda')
xlabel('velocity ft/s')

p_ss = @(x,y,z) (-x./y)*z;

degree = [5;10;15;20;25];
Navion_roll_ss = p_ss(Navion_L_d_a(4),Navion_L_P(4),deg2rad(degree));
Star_roll_ss = p_ss(Star_L_d_a(4),Star_L_P(4),deg2rad(degree));

figure(3)
plot(degree,Navion_roll_ss)
hold on
plot(degree,Star_roll_ss)
legend('Navion','Star')
xlabel('Input Angle Aileron')
ylabel('rad/s')
title('Max roll rate')

figure(4)
for i = 1:7
    x = tf(Navion_L_d_a(i)*deg2rad(25),[1,-Navion_L_P(i)]);
    step(x);
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title("Navion Step response")
figure(5)


for j = 1:7
    y = tf(Star_L_d_a(j)*deg2rad(25),[1,-Star_L_P(j)]);
    step(y);
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title('Star Step response')


% Partial Aileron Failure


Nav_L_d_a = L_d_a(Nav_Q,Nav_S,Nav_b,-0.134/2,Nav_Ix);
Sta_L_d_a = L_d_a(Sta_Q,Sta_S,Sta_b,0.039/2,Sta_Ix);

degree = [5;10;15;20;25];
Nav_roll_ss = p_ss(Nav_L_d_a(4),Navion_L_P(4),deg2rad(degree));
Sta_roll_ss = p_ss(Sta_L_d_a(4),Star_L_P(4),deg2rad(degree));

figure(10)
plot(degree,Nav_roll_ss)
hold on
plot(degree,Sta_roll_ss)
legend('Navion','Star')
xlabel('Input Angle Aileron degree')
ylabel('Roll rate rad/s')
title('Max roll rate, partial aileron failure')

figure(6)
for k = 1:7
    a = tf(Sta_L_d_a(k)*deg2rad(25),[1,-Star_L_P(k)]);
    step(a)
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title('Star Step response Aileron Failure')
ylabel('Roll Rate')

figure(7)
for l = 1:7
    b = tf(Nav_L_d_a(l)*deg2rad(25),[1,-Navion_L_P(l)]);
    step(b)
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title('Nav Step response Aileron Failure')
ylabel('Roll Rate')


Nav_ss_aileron = p_ss(Nav_L_d_a,Navion_L_P,deg2rad(25));
Sta_ss_aileron = p_ss(Sta_L_d_a,Star_L_P,deg2rad(25));

% More fuel in wing tips


m_Nav = 2750/32.2;
m_Sta = 16300/32.2;
g_Nav = m_Nav*0.25;
g_Sta = m_Nav*0.25;

Navion_Ix = Nav_Ix + g_Nav*Nav_C.^2;
Star_Ix = Sta_Ix + g_Sta*Sta_C.^2;

Nav_L_Pa = L_p(Nav_Q,Nav_S,Nav_b,-0.410,Navion_Ix,u);
Nav_L_d_aa = L_d_a(Nav_Q,Nav_S,Nav_b,-0.134,Navion_Ix);

Sta_L_Pa = L_p(Sta_Q,Sta_S,Sta_b,-0.285,Star_Ix,u);
Sta_L_d_aa = L_d_a(Sta_Q,Sta_S,Sta_b,0.039,Star_Ix);

Nav_ss_fuel = p_ss(Nav_L_d_aa(4),Nav_L_Pa(4),deg2rad(degree));
Sta_ss_fuel = p_ss(Sta_L_d_aa(4),Sta_L_Pa(4),deg2rad(degree));

figure(11)
plot(degree,Nav_ss_fuel)
hold on
plot(degree,Sta_ss_fuel)
legend('Navion','Star')
xlabel('Input Angle Aileron degree')
ylabel('Roll rate rad/s')
title('Max roll rate, more fuel')

figure(8)
for m = 1:7
    c = tf(Nav_L_d_aa(m)*deg2rad(25),[1,-Nav_L_Pa(m)]);
    step(c)
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title('Navion Step response More Fuel')
ylabel('Roll Rate')

figure(9)
for n = 1:7
    d = tf(Sta_L_d_aa(n)*deg2rad(25),[1,-Sta_L_Pa(n)]);
    step(d)
    hold on
end
legend('50 knots','75 knots','100 knots','125 knots','150 knots','175 knots','200 knots')
title('Star Step response More Fuel')
ylabel('Roll Rate')


