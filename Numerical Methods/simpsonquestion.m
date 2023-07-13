clc
clear

% 110180807 Nadir Doğan

a=0;
b=0.9; % from 0 to 9 for simpson 3/8
c=1.1; % from 9 to 11 for simpson 1/3
f0 = 2.595093;
f3 = 57.72181;
f6 = 95.16424;
f9 = 93.89335;
f10 = 81.54573;
f11 = 75.44009; %values from table
s3 = (b-a)*((f0+(3*f3)+(3*f6)+f9)/8);  % simpson 3/8 rule
s1 = (c-b)*((f9+(4*f10)+f11)/6); % simpson 1/3 rule
answer = s3 + s1;
fprintf('Work: %f', answer);