% Longitudnal dyanmics

% data is data, u is velocity not, y is flight path angle not
function [A B] = longdyna(D,u)
    % A = [D.Za/u 1 D.Zu/u -32.17*sin(o);
    %     D.Ma D.Mq D.Mu 0;
    %     D.Xw 0 D.Xu -32.17*cos(o);
    %     0 1 0 0];

    B = [D.Zadot/u^2;
        D.Madot/u;
        0;
        0];

    A = [D.Xu D.Xw 0 -32.17;
        D.Zu D.Zw u 0;
        D.Mu+D.Mwdot*D.Zu D.Mw+D.Mwdot*D.Zw D.Mq+D.Mwdot*u 0;
        0 0 1 0];
   