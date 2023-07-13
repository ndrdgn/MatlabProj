clc
clear
n=48; % Student Number
N=54000; % Iteration Number
dt=0.1; % (s) The sample time 
t(1)=0; % (s) Initial time 
Me=7.943*(10^15); % (Wb*m) The magnetic dipole moment of the Earth 
mu=3.98601*(10^14); % (m^3/s^2) The Earth gravitational constant 
i=(80+0.5*n)*(pi/180); % (rad) The Orbit inclination (Multiply by (pi / 180) to convert it to radians)
We=7.29*(10^-5); % (rad/s) The Spin Rate of the Earth 
E=(11.7)*(pi/180); % (rad) The Magnetic Dipole Tilt 
Ro=(6378.14+500+2*n)*1000; % (m) The distance between the center of mass of the satellite and the Earth.
Wo=sqrt(mu/Ro^3); % (rad/s) The angular velocity of the orbit with respect to the inertial frame 
 
for x=1:N % for loop to perform iteration
    
    % Time increases per iteration
    t(x+1)=t(x)+dt;
    
    % Earth's Magnetic Field Vector Components
    Hx(x)=(Me/Ro^3)*(cos(Wo*t(x))*(cos(E)*sin(i)-sin(E)*cos(i)*cos(We*t(x)))-sin(Wo*t(x))*sin(E)*sin(We*t(x)));
    Hy(x)=(-Me/Ro^3)*(cos(E)*cos(i)+sin(E)*sin(i)*cos(We*t(x)));
    Hz(x)=2*(Me/Ro^3)*(sin(Wo*t(x))*(cos(E)*sin(i)-sin(E)*cos(i)*cos(We*t(x)))-2*sin(Wo*t(x))*sin(E)*sin(We*t(x)));
    
    % Direction cosine elements of the magnetic field vector
    Hx0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hx(x);
    Hy0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hy(x);
    Hz0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hz(x);
    
end
 
% Earth's magnetic field vector components graphs 

figure
plot(t(1:54000),Hx);
title('X - Vector Magnetic Field Changes (Hx) - time');
xlabel(' (s) Time ');
ylabel('X - (Wb/m^2) Magnetic Field Vector Component');
 
figure
plot(t(1:54000),Hy);
title('Y - Vector Magnetic Field Changes (Hy) - time');
xlabel(' (s) Time ');
ylabel('Y - (Wb/m^2) Magnetic Field Vector Component');
 
figure
plot(t(1:54000),Hz);
title('Z - Vector Magnetic Field Changes (Hz) - time');
xlabel(' (s) Time ');
ylabel('Z - (Wb/m^2) Magnetic Field Vector Component ');
 
% Direction cosine elements of the magnetic field vector graphs
figure
plot(t(1:54000),Hx0);
title('X - Axis Cosine Element Direction Changes (Hx0) - time');
xlabel(' (s) Time ');
ylabel('X - Cosine Element Direction');
 
figure
plot(t(1:54000),Hy0);
title('Y - Axis Cosine Element Direction Changes (Hy0) - time');
xlabel(' (s) Time ');
ylabel('Y - Cosine Element Direction');
 
figure
plot(t(1:54000),Hz0);
title('Z - Axis Cosine Element Direction Changes (Hz0) - time');
xlabel(' (s) Time ');
ylabel('Z - Cosine Element Direction');

