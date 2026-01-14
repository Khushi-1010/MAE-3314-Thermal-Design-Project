%% Heat Transfer Key Assignment Problem-2 %%
% Author: Khushi Piparava
% Last Edited on: 12/06/2025

%{
PROBLEM 2 DESCRIPTION: This program models the transient heating of a thin metal strip inside
a high-temperature furnace using the lumped-capacitance method.
The strip is heated by convection on both surfaces as it travels through the furnace at a constant speed.

The code:
 1) Verifies the validity of the lumped-capacitance method using the
    Biot number.
 2) Computes the thermal time constant of the strip.
 3) Determines the time required for the strip to heat from 300°C to
    600°C at a furnace temperature of 700°C.
 4) Calculates the required furnace length based on strip velocity.
 5) Determines the new strip speeds required for furnace temperatures
    of 850°C and 1000°C for the same furnace length.
 6) Plots the transient temperature response of the strip for all
    furnace temperature conditions.
%}
clc; clear; close all;

%% ------------------ GIVEN DATA ------------------
delta = 0.012;          % Strip thickness (m)
rho   = 7900;           % Density (kg/m^3)
cp    = 640;            % Specific heat (J/kg-K)
k     = 30;             % Thermal conductivity (W/m-K)
h     = 100;            % Convection coefficient (W/m^2-K)

Ti = 300;               % Initial temperature (C)
T  = 600;               % Final required temperature (C)

Tinf = [700 850 1000];  % Furnace temperatures (C)

v1 = 0.5;               % Initial strip speed (m/s)

%% ------------------ LUMPED CAPACITANCE CHECK ------------------
Lc = delta/2;            % Characteristic length
Bi = h*Lc/k;

disp(['Biot Number = ', num2str(Bi)])

%% ------------------ TIME CONSTANT ------------------
tau = rho*cp*Lc/h;      % Time constant (s)
disp(['Time constant tau = ', num2str(tau), ' s'])

%% ------------------ PART (A): TIME & FURNACE LENGTH ------------------
t700 = tau * log((Tinf(1)-Ti)/(Tinf(1)-T));

Lf = v1 * t700;

disp(' ')
disp('---- PART (A) RESULTS ----')
disp(['Heating time at 700 C = ', num2str(t700), ' s'])
disp(['Required furnace length = ', num2str(Lf), ' m'])

%% ------------------ PART (B): NEW SPEEDS ------------------
t850  = tau * log((Tinf(2)-Ti)/(Tinf(2)-T));
t1000 = tau * log((Tinf(3)-Ti)/(Tinf(3)-T));

v850  = Lf / t850;
v1000 = Lf / t1000;

disp(' ')
disp('---- PART (B) RESULTS ----')
disp(['Heating time at 850 C = ', num2str(t850), ' s'])
disp(['New speed at 850 C = ', num2str(v850), ' m/s'])

disp(['Heating time at 1000 C = ', num2str(t1000), ' s'])
disp(['New speed at 1000 C = ', num2str(v1000), ' m/s'])

%% ------------------ PART (C): TEMPERATURE vs TIME PLOTS ------------------
t = linspace(0, t700, 400);

T700  = Tinf(1) + (Ti - Tinf(1)) .* exp(-t/tau);
T850  = Tinf(2) + (Ti - Tinf(2)) .* exp(-t/tau);
T1000 = Tinf(3) + (Ti - Tinf(3)) .* exp(-t/tau);

figure;
plot(t, T700,  'LineWidth', 2); hold on;
plot(t, T850,  'LineWidth', 2);
plot(t, T1000,'LineWidth', 2);

yline(600,'--k','LineWidth',1.5)

xlabel('Time (s)');
ylabel('Strip Temperature (°C)');
title('Strip Heating Using Lumped Capacitance Method');

legend('T_\infty = 700°C','T_\infty = 850°C','T_\infty = 1000°C','T = 600°C',...
       'Location','best');

grid on;
