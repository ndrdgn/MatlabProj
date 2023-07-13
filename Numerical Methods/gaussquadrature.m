clc
clear
a = -1;    
b = 1;     
t = [-0.90618 -0.53847 0];   % 3 point
t2 = [0.53847 0.90618]; % 2 point for n = 5
w = [0.23692 0.47863 0.56888];   %
w2 = [0.47863 0.23692]; % weight for n=5
f = 1/2*sqrt(1+((3+t).^2).*exp(((3+t).^2)/2)); %function 
f2 = sqrt(1+((3+t2).^2).*exp(((3+t2).^2)/2)); % function for t4 and t5

gaussleg = sum(w.*f);
gaussleg2 = sum(w2.*f2);
answer = 1/2*(gaussleg + gaussleg2);