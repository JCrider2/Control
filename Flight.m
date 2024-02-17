clear
clc
close all
% Flight Stuff
% all C values are per radians

air_data.C_L = 0.735;
air_data.C_D = 0.263;
air_data.C_L_A = 3.44;
air_data.C_D_A = 0.45;
air_data.C_M_A = -0.64;
air_data.C_L_Adot = 0.0;
air_data.C_M_Adot = -1.6;
air_data.C_L_Q = 0.0;
air_data.C_M_Q = -5.8;
air_data.C_L_M = 0.0;
air_data.C_D_M = 0.0;
air_data.C_M_M = 0.0;
air_data.C_L_D_E = 0.68;
air_data.C_M_D_E = -1.46;

air_data.C_Y_B = -1.17;
air_data.C_L_B = -0.175;
air_data.C_N_B = 0.5;
air_data.C_Y_P = 0;
air_data.C_L_P = -0.285;
air_data.C_N_P = -0.14;
air_data.C_Y_R = 0;
air_data.C_L_R = 0.265;
air_data.C_N_R = -0.75;
air_data.C_L_D_A = 0.039;
air_data.C_N_D_A = 0.0042;
air_data.C_Y_D_A = 0;
air_data.C_Y_D_R = 0.208;
air_data.C_L_D_R = 0.045;
air_data.C_N_D_R = -0.16;
u = 50; % ft/2
Q = dynamicPressure(u);
air_data.C_Z_Adot = -air_data.C_D-air_data.C_L_Adot;

air_data.M = 0.257;             % 
air_data.W = 16300;             % lb
air_data.m = air_data.W/32.17;  % slugs
air_data.Ix = 3544;             % slug-ft^2
air_data.Iy = 58611;            % slug-ft^2
air_data.Iz = 59669;            % slug-ft^2
air_data.Ixy = 0;               % slug-ft^2
air_data.S = 196.1;             % ft^2
air_data.b = 21.94;             % ft
air_data.c = 9.55;              % ft

air_data.C_M = air_data.M/(Q*air_data.S*air_data.c);


air_data.C_M_U = air_data.C_M/u;


a = deg2rad(45); % angle of attack point up ward
q = deg2rad(0); % angular rate

b = deg2rad(-45); % yaw angle
p = deg2rad(30); % roll rate
r = deg2rad(7); % yaw rate
phi = deg2rad(-9); % i don't know
w = a*u;

Ic_Laterl = [b; p; r; phi];

Ic_Dutch = [b; p; r];
Ic_Long = [u;w;q;a];



Lateral = Lateral(Q,air_data,u);
Longitud = Long(Q,air_data,u);
[A B] = LateralDynamics(Lateral,u,a);
[Ad Bd] = dutchRoll(Lateral,u);
[Ar Br] = rollConvergence(Lateral);
Test = ShortPeriod(Longitud,u);
[Al Bl] = longdyna(Longitud,u);

