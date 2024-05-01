clear
clc


t0 = 0;
tf = 30;
dt = 0.01;
i = 0;
aref = -4;
bref = 4;
y = 0;
q = 0;
bhat = -4;
bmin = 1;
ya = 200;
yb = 200;
Lt = 200;
e = 0;
gamma = 0;
ahat = 0;
that = 0;
gam = 0;

O = @(q) tanh(360/pi*q);
qdot = @(q,gamma) -0.61*q-6.65*gamma+(0.0665*tanh(360/pi*q)); 
j = 0;
xdot = @(a,b,x,u)  a*x+b*u;

for t = t0:dt:tf
    
    %input at time output is I

    if t >= 25
        i = 2
    elseif t >= 20   
        i = 0;
    elseif t >= 15
        i = -1;
    elseif t >= 10
        i = 0;
    elseif t >= 5
        i = 1;
    end
    j(end+1) = i;
    e = q(end) - y(end); % error

    adhat = ya*q(end)*e;
    
    tdhat = Lt*O(q(end))*e;
    
    if bhat < -bmin
       bdhat = yb*gamma*e;
    elseif bhat == -bmin && gamma*e < 0
        bdhat = yb*gamma*e;
    elseif bhat == -bmin && gamma*e > 0
        bdhat = 0;
    end

    y_dot = xdot(aref,bref,y(end),i);
    y_new = y(end)+y_dot*dt;
    y(end+1) = y_new;


    that = that+tdhat*dt;
    ahat = ahat+adhat*dt;
    bhat = bhat+bdhat*dt;

    gamma = (1/bhat)*((aref-ahat)*q(end)+bref*i-that*O(q(end)));
    gam(end+1) = gamma;
    q(end+1) = q(end)+qdot(q(end),gamma)*dt;

    

end
x = linspace(t0,tf,(tf-t0)/dt+2);
plot(x,j,'',x,q)