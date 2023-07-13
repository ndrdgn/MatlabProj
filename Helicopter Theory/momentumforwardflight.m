clc
clear

Gtow= 4953*9.81;                    % N
R = 14.6/2;                         % m -- rotor diameter 
Ro = 1.226;                         % kg/m^3
Area = 168.1;                       % m^2
Voo = 97.7;                         % m/s -- 352 km/h --> 97.7 m/s
Vtip = R*2*pi*(360/60);             % m/s tip velocity 
a1 = 0*pi/180;                      % hover con.
a2 = 4*pi/180;                      % forward flight
Th = Gtow/cos(a1);                  % N -- Thrust hover con.
Cth = Th / ((1/2)*Ro*Area*Vtip^2);  % Thrust coefficient hover con.
L(1) = sqrt(Cth/2);                 % hover condition Lambda
T = Gtow/cos(a2);                   % N -- Thrust forward flight
Ct = T / ((1/2)*Ro*Area*Vtip^2);    % Thrust coefficient forward flight
Mu = (Voo*cos(a2))/Vtip;            % advance ratio
                     

for i=1:100 % 100 = iteration number -- FIXED POINT ITERATION METHOD
    L(i+1)=(Mu*tan(a2))+(Ct/(2*sqrt(Mu^2+L(i)^2)));
    err = abs((L(i+1)-L(i))/L(i+1));
    forplot(i+1) = i;
    if err < 0.0005                 % error estimate
        fprintf('Fixed Point Iteration Method Inflow ratio: %d, Iteration Number : %d \n', L(i+1), double(i))
        break
    end
end

L2(1) = L(1);
for k=1:100 % 100 = iteration number -- NEWTON-RAPHSON METHOD
    fL2(k+1) = L2(k)-(Mu*tan(a2))-(Ct/(2*sqrt(Mu^2+L2(k)^2)));
    fL2dot(k+1) = 1 + Ct*L2(k)*((Mu^2 + L2(k)^2)^(-3/2))/2;
    L2(k+1) = L2(k) - ((fL2(k+1))/fL2dot(k+1));
    forplot2(k+1) = k;
    err2 = abs((L2(k+1)-L2(k))/L2(k+1));
    if err2 < 0.0005                % error estimate
        fprintf('Newton-Raphson Method Inflow ratio: %d, Iteration Number : %d \n', L2(k+1), double(k))
        break
    end
end

    hold on
    grid on
    plot(forplot,L)
    plot(forplot2,L2,'-.')
    legend('Fixed Point Iteration Method','Newton-Raphson Method')
    title('Inflow ratio for iteration number');
    xlabel('Iteration Number');
    ylabel('Inflow Ratio(\lambda)');