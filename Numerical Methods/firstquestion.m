clc
clear
close all

% deltax=0.25 
xi=0:0.25:2 ;
% given data
fi=[0 0.72424 1.2456 1.1509 0.14112 -0.14201 -0.054153 -0.012912 -0.0013662];
% deltax=0.1
newxi=0:0.1:2;

% a)lagrange
n=length(xi)-1;
syms xx;
S=0;
for i=1:n+1
    L=1;
    for j=1:n+1
        if j~=i
            L=L*(xx-xi(j))/(xi(i)-xi(j));
        end
    end
    S=S+fi(i)*L;
end
% polynomial
S=expand(S);
lgrn(xx)=S;
for i=1:length(newxi)
    y1(i)=double(lgrn(newxi(i)));
end

% b)linear 
p1=polyfit(xi,fi,1);
y2=polyval(p1,newxi);

% c)quadratic 
p2=polyfit(xi,fi,2);
y3=polyval(p2,newxi);

% d)cubic 
p3=polyfit(xi,fi,3);
y4=polyval(p3,newxi);

fprintf('\tx, lagrange, linear, quadratic, cubic\n')
%printing
for i=1:length(newxi)
    fprintf('\t%2.2f, %2.4f, %2.4f, %2.4f, %2.4f\n',newxi(i),y1(i),y2(i),y3(i),y4(i))
end

%plotting
plot(xi,fi,'r*')
hold on
plot(newxi,y1)
plot(newxi,y2)
plot(newxi,y3)
plot(newxi,y4)
xlabel('x')
ylabel('f(x)')
title('Xi vs. Fi plot')
legend('Given data','lagrange','linear','quadratic','cubic')
