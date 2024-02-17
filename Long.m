
% Longitudinal Derivatves x
function Longer = Long(Q,Data,u)

    Longer.Xu = -((Data.C_D/u+2*Data.C_D)*Q*Data.S)/(Data.m*u); % s^-1
    Longer.Xw = -((Data.C_D_A-Data.C_L)*Q*Data.S)/(Data.m*u);   % s^-1
    Longer.Zu = -((Data.C_L/u+2*Data.C_L)*Q*Data.S)/(Data.m*u); % s^-1
    Longer.Zw = -((Data.C_L_A+Data.C_D)*Q*Data.S)/(Data.m*u);   % s^-1
    Longer.Zwdot = ((Q*Data.S*Data.c)/(2*Data.m*u^2))*Data.C_Z_Adot; % dimensionless
    Longer.Za = u*Longer.Zw;
    Longer.Zadot = u*Longer.Zwdot;
    Longer.Zq = Data.C_L_Q*(Data.c/(2*u))*Q*Data.S/Data.m;      % ft/s
    Longer.Mw = Data.C_M_A*(Q*Data.S*Data.c)/(u*Data.Iy);       % 1/ft-s
    Longer.Ma = u*Longer.Mw;                                    % s^-2
    Longer.Mq = Data.C_M_Q*(Data.c/(2*u))*(Q*Data.S*Data.c)/Data.Iy; % s^-1
    Longer.Mu = Data.C_M_U*((Q*Data.S*Data.c)/(u*Data.Iy));     % 1/ft-s
    Longer.Mwdot = Data.C_M_Adot*(Data.c/(2*u))*((Q*Data.S*Data.c)/(u*Data.Iy)); % ft^-1
    Longer.Madot = Longer.Mwdot*u;                                 % s^-1
    


end