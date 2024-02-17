
% Lateral Dynamics
% Lat is lateral, u is velocity, o is roll angle
function [A,B] = LateralDynamics(Lat,u,o)

    A = [Lat.Yb/u Lat.Yp -(1-Lat.Yr/u) 32.17*cos(o)/u;
        Lat.Lb Lat.Lp Lat.Lr 0;
        Lat.Nb Lat.Np Lat.Nr 0;
        0 1 0 0];
    B = [0 Lat.Ydr;
        Lat.Lda Lat.Ldr;
        Lat.Nda Lat.Ndr;
        0 0];

end

