
% u is velcity, imperial units
% y is dynamic prssure at sea level

function [y] = dynamicPressure(u)
    y = 0.5*0.0765*u^2;
end