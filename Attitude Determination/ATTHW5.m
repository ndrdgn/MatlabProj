clear
clc

n=48; % Student Number
t(1)=0; % (s) Initial time 
t2(1)=0; % (s) Second Initial time  
dt=0.1; % (s) The sample time

N=54000; % The Iteration Number

Me=7.943*(10^15); % (Wb*m) The magnetic dipole moment of the Earth
i=(80+0.5*n)*(pi/180); % (rad) The Orbit inclination (Multiply by (pi / 180) to convert it to radians)
We=7.29*(10^-5); % (rad/s) The Spin Rate of the Earth
E=(11.7)*(pi/180); % (rad) The Magnetic Dipole Tilt
mu=3.98601*(10^14); % (m^3/s^2) The Earth gravitational constant
ro=(6378.14+500+2*n)*1000; % (m) The distance between the center of mass of the satellite and the Earth.
Wo=sqrt(mu/ro^3); % (rad/s) The angular velocity of the orbit with respect to the inertial frame 
Worbit=0.0011; %  (rad/s) The angular orbit velocity of satellite
Nt=3.6*(10^-10); % (N*m) Disturbance torque acting on the satellite 
 
% The moments of inertia of the satellite
Jx=2.1*10^-3;    
Jy=2*10^-3;
Jz=1.9*10^-3;
 
% (rad) Initial data of the attitude angles 
q1(1)=0.002*n;
q2(1)=0.001*n;
q3(1)=0.005*n;
q4(1)=sqrt(1-q1(1)^2-q2(1)^2-q3(1)^2);
 
% The initial data of the satellite’s angular velocities
Wx(1)=0.0002+0.0001*n;
Wy(1)=0.0003+0.0001*n;
Wz(1)=0.0004+0.0001*n;
 
C=cell(N,1);   % cell contains all transformation matrices C
A=cell(N,1);   % cell contains all transformation matrices A
 
for i=1:N
    
    % Time increases per iteration
    t(i+1)=t(i)+dt;
    
    % The Angular Velocities
    Wx(i+1)=Wx(i)+(dt/Jx)*(Wz(i)*Wy(i)+Nt)*(Jy-Jz);
    Wy(i+1)=Wy(i)+(dt/Jy)*(Wx(i)*Wz(i)+Nt)*(Jz-Jx);
    Wz(i+1)=Wz(i)+(dt/Jz)*(Wx(i)*Wy(i)+Nt)*(Jx-Jy);
    
    % The Quaternions
    q1(i+1)=q1(i)-0.5*dt*(q2(i)*Wx(i)+q3(i)*Wy(i)+q4(i)*Wz(i));
    q2(i+1)=q2(i)+0.5*dt*(q1(i)*Wx(i)-q4(i)*Wy(i)+q3(i)*Wz(i));
    q3(i+1)=q3(i)+0.5*dt*(q4(i)*Wx(i)+q1(i)*Wy(i)-q2(i)*Wz(i));
    q4(i+1)=q4(i)-0.5*dt*(q3(i)*Wx(i)-q2(i)*Wy(i)-q1(i)*Wz(i));
    
    % The Transformation Matrix 
    c11(i)=q1(i)^2-q2(i)^2-q3(i)^2+q4(i)^4;
    c12(i)=2*(q1(i)*q2(i)+q3(i)*q4(i));
    c13(i)=2*(q1(i)*q3(i)-q2(i)*q4(i));
    c21(i)=2*(q1(i)*q2(i)-q3(i)*q4(i));
    c22(i)=-q1(i)^2+q2(i)^2-q3(i)^3+q4(i)^2;
    c23(i)=2*(q2(i)*q3(i)-q1(i)*q4(i));
    c31(i)=2*(q1(i)*q3(i)+q2(i)*q4(i));
    c32(i)=2*(q2(i)*q3(i)-q1(i)*q4(i));
    c33(i)=-q1(i)^2-q2(i)^2+q3(i)^2+q4(i)^2;
    
    C{i}=[c11(i),c12(i),c13(i);c21(i),c22(i),c23(i);c31(i),c32(i),c33(i)];
end
 
 
for x=1:N
    
    % Time increases per iteration
    t2(x+1)=t2(x)+dt;
    
    % Earth's Magnetic Field Vector Components
    Hx(x)=(Me/ro^3)*(cos(Wo*t(x))*(cos(E)*sin(i)-sin(E)*cos(i)*cos(We*t(x)))-sin(Wo*t(x))*sin(E)*sin(We*t(x)));
    Hy(x)=(-Me/ro^3)*(cos(E)*cos(i)+sin(E)*sin(i)*cos(We*t(x)));
    Hz(x)=2*(Me/ro^3)*(sin(Wo*t(x))*(cos(E)*sin(i)-sin(E)*cos(i)*cos(We*t(x)))-2*sin(Wo*t(x))*sin(E)*sin(We*t(x)));
    
    % Direction cosine elements of the magnetic field vector
    Hx0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hx(x);
    Hy0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hy(x);
    Hz0(x)=(1/sqrt(Hx(x)^2+Hy(x)^2+Hz(x)^2))*Hz(x);
    
     H{x}=[Hx(x);Hy(x);Hz(x)];
    H0{x}=[Hx0(x);Hy0(x);Hz0(x)];
    
end
 
 
 
% Standart Deviation of Each Magnetometer Error
sigmamc = 0.008;
sigmam = 1.66*(10^(-6));                % 1 W/m^2=1T=10^6nuT
 
% Components of Magnetometer Bias Vector
bx = 3*(10^(-6));
by = 5*(10^(-6));
bz = 6*(10^(-6));
bcx = 0.04;
bcy = 0.06;
bcz = 0.08;  
 
% Magnetometer Bias Vector
b = [bx;by;bz];               
bc = [bcx;bcy;bcz];  
 
C2=cell(N,1);          %cell contains all the N2 number of Transformation Matrices C2
C2=C(1:1:54000);
Bm0=cell(N,1);              
Bm=cell(N,1);               
Bm0star=cell(N,1);          
Bmstar=cell(N,1);      
 
for x=1:N
    
    t2(x+1)=t2(x)+dt;
    
    Bm0{x}=C2{x}*H0{x}+bc+sigmamc*randn;
    Bm01(x)=Bm0{x}(1,1);
    Bm02(x)=Bm0{x}(2,1);
    Bm03(x)=Bm0{x}(3,1);
    
    Bm{x}=C2{x}*H{x}*10^6+b+sigmam*randn;
    Bm1(x)=Bm{x}(1,1);
    Bm2(x)=Bm{x}(2,1);
    Bm3(x)=Bm{x}(3,1);
    
    Bm0star{x}=C2{x}*H0{x};
    Bm0star1(x)=Bm0star{x}(1,1);
    Bm0star2(x)=Bm0star{x}(2,1);
    Bm0star3(x)=Bm0star{x}(3,1);
    
    Bmstar{x}=C2{x}*H{x}*(10^6);
    Bmstar1(x)=Bmstar{x}(1,1);
    Bmstar2(x)=Bmstar{x}(2,1);
    Bmstar3(x)=Bmstar{x}(3,1);
    
end
 
% Graphs
figure 
plot(t2(1:54000),Bm01)
title('(Bm0) - Magnetometer measurement model Hx0 changes - time')
xlabel('(s) Time')
ylabel('Magnetometers Hx0 Component')
 
figure
plot(t2(1:54000),Bm0star1)
title('(Bm0*) - Magnetometer measurement model Hx0 changes - time')
xlabel('(s) Time')
ylabel('Magnetometer Hx0 Component')
 
figure
plot(t2(1:54000),Bm01)
hold on
plot(t2(1:54000),Bm0star1)
hold off
title('Magnetometer measurement model Hx0 changes - time')
xlabel('(s) Time')
ylabel('Magnetometers Hx0 Component')
legend('B_m_0_1','B_m_0_1^*')
 
figure
plot(t2(1:54000),Bm02)
title('(Bm0) - Magnetometer measurement model Hy0 changes - time')
xlabel('(s) Time')
ylabel('Magnetometer Hy0 Component')
 
figure
plot(t2(1:54000), Bm0star2)
title('(Bm0*) - Magnetometer measurement model Hy0 changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hy0 Component')
 
figure
plot(t2(1:54000),Bm02)
hold on
plot(t2(1:54000),Bm0star2)
hold off
title('Magnetometer measurement model Hy0 changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hy0 Component')
legend('B_m_0_2','B_m_0_2^*')
 
figure
plot(t2(1:54000) , Bm03)
title('(Bm0) - Magnetometer measurement model Hz0 changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hz0 Component')
 
figure
plot(t2(1:54000) , Bm0star3)
title('(Bm0*) - Magnetometer measurement model Hz0 changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hz0 Component')
 
figure
plot(t2(1:54000),Bm03)
hold on
plot(t2(1:54000),Bm0star3)
hold off
title('Magnetometer measurement model Hz0 changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hz0 Component')
legend('B_m_0_3','B_m_0_3^*')
 
figure
plot(t2(1:54000), Bm1)
title('(Bm) - Magnetometer measurement model Hx changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hx Component')
 
figure
plot(t2(1:54000),Bmstar1)
title('Bm*) - Magnetometer measurement model Hx changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hx Component')
 
figure
plot(t2(1:54000),Bm1)
hold on
plot(t2(1:54000),Bmstar1)
hold off
title('Magnetometer Measurement Model Hx changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hx Component')
legend('B_m_1','B_m_1^*')
 
figure
plot(t2(1:54000), Bm2)
title('(Bm) - Magnetometer measurement model Hy changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hy Component')
 
figure
plot(t2(1:54000), Bmstar2)
title('(Bm*) - Magnetometer measurement model Hy changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hy Component')
 
figure
plot(t2(1:54000),Bm2)
hold on
plot(t2(1:54000),Bmstar2)
hold off
title('Magnetometer measurement model Hy changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hy Component ')
legend('B_m_2','B_m_2^*')
 
figure 
plot(t2(1:54000), Bm3)
title('(Bm) - Magnetometer measurement model Hz changes - time')
xlabel('(s) Time)')
ylabel('Mgnetometers Hz Component')
 
figure
plot(t2(1:54000), Bmstar3)
title('(Bm*) - Magnetometer measurement model Hz changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hz Component')
 
figure
plot(t2(1:54000), Bm3)
figure
plot(t2(1:54000),Bm3)
hold on
plot(t2(1:54000),Bmstar3)
hold off
title('Magnetometer measurement model Hz changes - time')
xlabel('(s) Time)')
ylabel('Magnetometers Hz Component')
legend('B_m_3','B_m_3^*')