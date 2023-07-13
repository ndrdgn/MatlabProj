clc
clear all

Ro = 1.225;                     % Sea level air density at  - kg/m^3
To = 288.15;                    % Sea level air temparature - K
altitude = [1000,3000,5000];    % Given density altitudes - m
k = 1.15;                       % In hover case k value is 1.10-1.15
Gtow = 4953*9.81;               % Weight of helicopter - N
T = Gtow;                       % Thrust in hover case - N
% Main Rotor
Po = 2*1300*1000;               % 2× General Electric T700 engine - W
N = 2;                          % Number of blades
r = 14.6/2 ;                    % Rotor radius (Rotor diameter 14.6m) - m
Da = 168.11;                    % Disc area - m^2 
omega = 2*pi*(360/60);          % Velocity, RPM = 360 - 1/s
Cdo = 0.008;                    % Drag coefficient 
c = 0.84;                       % Chord - m
solidity = N*c/(pi*r);          % Solidity 
% Tail Rotor
Nt = 2;                         % Number of blades
rt = 2.97/2 ;                   % Rotor radius (Rotor diameter 2.97m) - m
Dat = 6.94;                     % Disc area - m^2
omega_t = 2*pi*(1200/60);       % Velocity, RPM = 1200 - 1/s
Cdot = 0.008;                   % Drag coefficient 
ct = 0.305;                     % Chord - m
solidityt = Nt*ct/(pi*rt);      % Solidity 
Dstncem_t = 8.89;               % Distance between rotor centers - m 

% a) Calculation of the air density at 3 different altitudes, ρ
Talt = 15.04 - 0.00649 * altitude                        
Pres = (101.29) * ((Talt + 273.15)/288.08).^(5.256)
Roalt =  Pres./(0.2869*(Talt + 273.15))
% b) Calculation of the available engine power at different altitudes.
Poav = Po.*(Roalt/Ro)
% c) Power and power coefficient of the main rotor at each altitude
Pim = (k.*T.^1.5)./(sqrt(2.*Roalt*Da))
Pom = Da.*Roalt.*((omega*r)^3)*solidity*Cdo/8
Phm = Pim + Pom
Cpm = Phm./(Roalt.*Da.*((omega*r)^3))
% d) Calculation of the thrust developed by the tail rotor
Q_main_h = Phm./omega
T_t = Q_main_h./Dstncem_t
% e) Power and power coefficient of the tail rotor at each altitude
Pit = (k.*T_t.^1.5)./(sqrt(2.*Roalt*Dat))
Pot = Dat.*Roalt.*((omega_t*rt)^3)*solidityt*Cdot/8
Pht = Pit + Pot 
Cpt = Pht./(Roalt.*Dat.*((omega_t*rt)^3))
% f) Calculation of the excess power at each altitude
Deltap = Poav - (Phm+Pht)
% Calculation of available maximum climb velocity
V_c = Deltap./Gtow
% g) Calculation of the Figure of Merit (FM) at each altitude
ct =T./(Roalt.*(omega.*r).^2.*Da)
Pideal = ct.^(3/2)./sqrt(2)
FM = Pideal ./(k.*Pideal + (solidity.*Cdo./8))

