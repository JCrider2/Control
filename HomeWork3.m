clear
clc
close all


% Homework 3

data.d230 = readtable('2_Blade_30_PReading');
data.d250 = readtable('2_Blade_50_PReading');
data.d270 = readtable('2_Blade_70_PReading');
data.d330 = readtable('3_Blade_30_PReading');
data.d350 = readtable('3_Blade_50_PReading');
data.d370 = readtable('3_Blade_70_PReading');

%% This changes each column to become dBA, while p is thrown as p is consistance for all
fs = 25000;
[b,a] = adsgn(fs);
for i = 1:8
    y = table2array(data.d230(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d230a(:,i) = p; % dBA
end
%figure(1)
%plot(e,d230a)
%hold on
for i = 1:8
    y = table2array(data.d250(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d250a(:,i) = p; % dBA
end
%plot(e,d250a)
%hold on
for i = 1:8
    y = table2array(data.d270(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d270a(:,i) = p; % dBA
end
%plot(e,d270a)




for i = 1:8
    y = table2array(data.d330(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d330a(:,i) = p; % dBA
end
for i = 1:8
    y = table2array(data.d350(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d350a(:,i) = p; % dBA
end
for i = 1:8
    y = table2array(data.d370(:,i));
    x = filter(b,a,y);
    [p,e] = oct3bank(x);
    d370a(:,i) = p; % dBA
end

%% This manually plots frequncy vs dBA, with figure 2 pertaining to 2 blade, figure 3 pertains to 3 blade

% plot for each mic, with three
figure(2)
plot(e,d230a(:,1),e,d250a(:,1),e,d270a(:,1))
title('Mic 1, 2 blade')
legend('30 %','50 %','70 %')
xlabel('Frequency')
ylabel('Noise dBA')

figure(3)
plot(e,d330a(:,1),e,d350a(:,1),e,d370a(:,1))
title('Mic 1, 3 blade')
legend('30 %','50 %','70 %')
xlabel('Frequency')
ylabel('Noise dBA')

%% This is for distance vs dBA, manually picked from previous plots

inverse = @(P,R) P - 20*log(R); % 50 is background noise

blad2 = [max(d230a(:,1)),max(d250a(:,1)),max(d270a(:,1))];
blad3 = [max(d330a(:,1)),max(d350a(:,1)),max(d370a(:,1))];

R = linspace(1,100,1001);
z = ones(1,1001)*50;

figure(4)
plot(R,z)
hold on
for i = 1:3
    p = inverse(blad2(i),R);
    
    plot(p,R)
    hold on
end
title('Distance to Noise level, 2 Blade')
xlabel('distance meters')
ylabel('Noise dBA')
legend('30 %','50 %','70 %')

figure(5)
plot(R,z)
hold on
for i = 1:3
    p = inverse(blad3(i),R);
    plot(p,R)
    hold on
end
title('Distance to Noise level, 3 Blade')
xlabel('distance meters')
ylabel('Noise dBA')
legend('30 %','50 %','70 %')





