clc
clear

a=1;
b=2;
n=10;
h=(b-a)/n;
x = linspace (a,b,n+1);
y = exp(x.^2);
dy = 2.*x.*y;
f = sqrt(1+(dy.^2));
answer = h/2 * ((f(1)+f(end))+2*(f(2)+f(3)+f(4)+f(5)+f(6)+f(7)+f(8)+f(9)+f(10)));