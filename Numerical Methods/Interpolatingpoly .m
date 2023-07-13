clear;
clc;

% T
x0 = 50;
x1 = 100;
x2 = 150;
x3 = 200;
x4 = 250;
x5 = 300;
x6 = 400; 
x7 = 500;

% (v) (m^3/kg)
v0 =14.867;
v1 =17.196;
v2 =19.513;
v3 =21.826;
v4 =24.136;
v5 =26.446;
v6 =31.063;
v7 =35.680;

% S values for (v)
Sv1y0 = (v1-v0)/(x1-x0);
Sv1y1 = (v2-v1)/(x2-x1);
Sv1y2 = (v3-v2)/(x3-x2);
Sv1y3 = (v4-v3)/(x4-x3);
Sv1y4 = (v5-v4)/(x5-x4);
Sv1y5 = (v6-v5)/(x6-x5);
Sv1y6 = (v7-v6)/(x7-x6);

Sv2y0 = (Sv1y1-Sv1y0)/(x2-x0);
Sv2y1 = (Sv1y2-Sv1y1)/(x3-x1);
Sv2y2 = (Sv1y3-Sv1y2)/(x4-x2);
Sv2y3 = (Sv1y4-Sv1y3)/(x5-x3);
Sv2y4 = (Sv1y5-Sv1y4)/(x6-x4);
Sv2y5 = (Sv1y6-Sv1y5)/(x7-x5);

Sv3y0 = (Sv2y1-Sv2y0)/(x3-x0);
Sv3y1 = (Sv2y2-Sv2y1)/(x4-x1);
Sv3y2 = (Sv2y3-Sv2y2)/(x5-x2);
Sv3y3 = (Sv2y4-Sv2y3)/(x6-x3);
Sv3y4 = (Sv2y5-Sv2y4)/(x7-x4);

Sv4y0 = (Sv3y1-Sv3y0)/(x4-x0);
Sv4y1 = (Sv3y2-Sv3y1)/(x5-x1);
Sv4y2 = (Sv3y3-Sv3y2)/(x6-x2);
Sv4y3 = (Sv3y4-Sv3y3)/(x7-x3);

Sv5y0 = (Sv4y1-Sv4y0)/(x5-x0);
Sv5y1 = (Sv4y2-Sv4y1)/(x6-x1);
Sv5y2 = (Sv4y3-Sv4y2)/(x7-x2);

Sv6y0 = (Sv5y1-Sv5y0)/(x6-x0);
Sv6y1 = (Sv5y2-Sv5y1)/(x7-x1);

Sv7y0 = (Sv6y1-Sv6y0)/(x7-x0);

Xv = zeros(46,1);
Yv = zeros(46,1);

% (u) kJ/kg
u0 =2443.3;
u1 =2515.5;
u2 =2587.9;
u3 =2661.4;
u4 =2736.1;
u5 =2812.3;
u6 =2969.3;
u7 =3132.9;

% S values for (u)
Su1y0 = (u1-u0)/(x1-x0);
Su1y1 = (u2-u1)/(x2-x1);
Su1y2 = (u3-u2)/(x3-x2);
Su1y3 = (u4-u3)/(x4-x3);
Su1y4 = (u5-u4)/(x5-x4);
Su1y5 = (u6-u5)/(x6-x5);
Su1y6 = (u7-u6)/(x7-x6);

Su2y0 = (Su1y1-Su1y0)/(x2-x0);
Su2y1 = (Su1y2-Su1y1)/(x3-x1);
Su2y2 = (Su1y3-Su1y2)/(x4-x2);
Su2y3 = (Su1y4-Su1y3)/(x5-x3);
Su2y4 = (Su1y5-Su1y4)/(x6-x4);
Su2y5 = (Su1y6-Su1y5)/(x7-x5);

Su3y0 = (Su2y1-Su2y0)/(x3-x0);
Su3y1 = (Su2y2-Su2y1)/(x4-x1);
Su3y2 = (Su2y3-Su2y2)/(x5-x2);
Su3y3 = (Su2y4-Su2y3)/(x6-x3);
Su3y4 = (Su2y5-Su2y4)/(x7-x4);

Su4y0 = (Su3y1-Su3y0)/(x4-x0);
Su4y1 = (Su3y2-Su3y1)/(x5-x1);
Su4y2 = (Su3y3-Su3y2)/(x6-x2);
Su4y3 = (Su3y4-Su3y3)/(x7-x3);

Su5y0 = (Su4y1-Su4y0)/(x5-x0);
Su5y1 = (Su4y2-Su4y1)/(x6-x1);
Su5y2 = (Su4y3-Su4y2)/(x7-x2);

Su6y0 = (Su5y1-Su5y0)/(x6-x0);
Su6y1 = (Su5y2-Su5y1)/(x7-x1);

Su7y0 = (Su6y1-Su6y0)/(x7-x0);

Xu = zeros(46,1);
Yu = zeros(46,1);

%Enthalpy (h) kJ/kg
h0 =2592.0;
h1 =2687.5;
h2 =2783.0;
h3 =2879.6;
h4 =2977.5;
h5 =3076.7;
h6 =3280.0;
h7 =3489.7;

% S values for (h)
Sh1y0 = (h1-h0)/(x1-x0);
Sh1y1 = (h2-h1)/(x2-x1);
Sh1y2 = (h3-h2)/(x3-x2);
Sh1y3 = (h4-h3)/(x4-x3);
Sh1y4 = (h5-h4)/(x5-x4);
Sh1y5 = (h6-h5)/(x6-x5);
Sh1y6 = (h7-h6)/(x7-x6);

Sh2y0 = (Sh1y1-Sh1y0)/(x2-x0);
Sh2y1 = (Sh1y2-Sh1y1)/(x3-x1);
Sh2y2 = (Sh1y3-Sh1y2)/(x4-x2);
Sh2y3 = (Sh1y4-Sh1y3)/(x5-x3);
Sh2y4 = (Sh1y5-Sh1y4)/(x6-x4);
Sh2y5 = (Sh1y6-Sh1y5)/(x7-x5);

Sh3y0 = (Sh2y1-Sh2y0)/(x3-x0);
Sh3y1 = (Sh2y2-Sh2y1)/(x4-x1);
Sh3y2 = (Sh2y3-Sh2y2)/(x5-x2);
Sh3y3 = (Sh2y4-Sh2y3)/(x6-x3);
Sh3y4 = (Sh2y5-Sh2y4)/(x7-x4);

Sh4y0 = (Sh3y1-Sh3y0)/(x4-x0);
Sh4y1 = (Sh3y2-Sh3y1)/(x5-x1);
Sh4y2 = (Sh3y3-Sh3y2)/(x6-x2);
Sh4y3 = (Sh3y4-Sh3y3)/(x7-x3);

Sh5y0 = (Sh4y1-Sh4y0)/(x5-x0);
Sh5y1 = (Sh4y2-Sh4y1)/(x6-x1);
Sh5y2 = (Sh4y3-Sh4y2)/(x7-x2);

Sh6y0 = (Sh5y1-Sh5y0)/(x6-x0);
Sh6y1 = (Sh5y2-Sh5y1)/(x7-x1);

Sh7y0 = (Sh6y1-Sh6y0)/(x7-x0);

Xh = zeros(46,1);
Yh = zeros(46,1);



%Entropy (s) kJ/kg.K
s0 =8.1741;
s1 =8.4489;
s2 =8.6893;
s3 =8.9049;
s4 =9.1015;
s5 =9.2827;
s6 =9.6094;
s7 =9.8998;

% S values for (s)
Ss1y0 = (s1-s0)/(x1-x0);
Ss1y1 = (s2-s1)/(x2-x1);
Ss1y2 = (s3-s2)/(x3-x2);
Ss1y3 = (s4-s3)/(x4-x3);
Ss1y4 = (s5-s4)/(x5-x4);
Ss1y5 = (s6-s5)/(x6-x5);
Ss1y6 = (s7-s6)/(x7-x6);

Ss2y0 = (Ss1y1-Ss1y0)/(x2-x0);
Ss2y1 = (Ss1y2-Ss1y1)/(x3-x1);
Ss2y2 = (Ss1y3-Ss1y2)/(x4-x2);
Ss2y3 = (Ss1y4-Ss1y3)/(x5-x3);
Ss2y4 = (Ss1y5-Ss1y4)/(x6-x4);
Ss2y5 = (Ss1y6-Ss1y5)/(x7-x5);

Ss3y0 = (Ss2y1-Ss2y0)/(x3-x0);
Ss3y1 = (Ss2y2-Ss2y1)/(x4-x1);
Ss3y2 = (Ss2y3-Ss2y2)/(x5-x2);
Ss3y3 = (Ss2y4-Ss2y3)/(x6-x3);
Ss3y4 = (Ss2y5-Ss2y4)/(x7-x4);

Ss4y0 = (Ss3y1-Ss3y0)/(x4-x0);
Ss4y1 = (Ss3y2-Ss3y1)/(x5-x1);
Ss4y2 = (Ss3y3-Ss3y2)/(x6-x2);
Ss4y3 = (Ss3y4-Ss3y3)/(x7-x3);

Ss5y0 = (Ss4y1-Ss4y0)/(x5-x0);
Ss5y1 = (Ss4y2-Ss4y1)/(x6-x1);
Ss5y2 = (Ss4y3-Ss4y2)/(x7-x2);

Ss6y0 = (Ss5y1-Ss5y0)/(x6-x0);
Ss6y1 = (Ss5y2-Ss5y1)/(x7-x1);

Ss7y0 = (Ss6y1-Ss6y0)/(x7-x0);

Xs = zeros(46,1);
Ys = zeros(46,1);


d1 = 50;
for x=50:10:500  
f2 = u0 + Su1y0*(x-x0)  +  Su2y0*(x-x0)*(x-x1)  +  Su3y0*(x-x0)*(x-x1)*(x-x2)  +  Su4y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)  +  Su5y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)  +  Su6y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)  +  Su7y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)*(x-x6);
d1 = d1 + 10;
a = (x/10)-4;
Xu(a)=f2;
end
for y=50:10:500
    a = (y/10)-4;
    Yh(a)=y;
end  

d2 = 50;
for x=50:10:500 
f1 = v0 + Sv1y0*(x-x0)  +  Sv2y0*(x-x0)*(x-x1)  +  Sv3y0*(x-x0)*(x-x1)*(x-x2)  +  Sv4y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)  +  Sv5y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)  +  Sv6y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)  +  Sv7y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)*(x-x6);
%fprintf('Degree: %d         Value: %d\n',Degree, Function);
d2 = d2 + 10;
a = (x/10)-4;
Xv(a)=f1;
end
for y=50:10:500
    a = (y/10)-4;
    Yu(a)=y;
end  

d3 = 50;
for x=50:10:500 
f3 = h0 + Sh1y0*(x-x0)  +  Sh2y0*(x-x0)*(x-x1)  +  Sh3y0*(x-x0)*(x-x1)*(x-x2)  +  Sh4y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)  +  Sh5y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)  +  Sh6y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)  +  Sh7y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)*(x-x6);
d3 = d3 + 10;
a = (x/10)-4;
Xh(a)=f3;
end

for y=50:10:500
    a = (y/10)-4;
    Yv(a)=y;
end  
d4 = 50;
for x=50:10:500 
f4 = s0 + Ss1y0*(x-x0)  +  Ss2y0*(x-x0)*(x-x1)  +  Ss3y0*(x-x0)*(x-x1)*(x-x2)  +  Ss4y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)  +  Ss5y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)  +  Ss6y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)  +  Ss7y0*(x-x0)*(x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5)*(x-x6);
d4 = d4 + 10;
a = (x/10)-4;
Xs(a)=f4;
end

for y=50:10:500
    a = (y/10)-4;
    Ys(a)=y;
end  

c0=Yv(:,1);
c1=Xv(:,1);
c2=Xu(:,1);
c3=Xh(:,1);
c4=Xs(:,1);
Table = (zeros(46,5));
Table(:,1)=c0;
Table(:,2)=c1;
Table(:,3)=c2;
Table(:,4)=c3;
Table(:,5)=c4;
Table
