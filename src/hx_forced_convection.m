%% Heat Transfer Key Assignment Problem-1 %%
% Author: Khushi Piparava
% Last Edited on: 12/06/2025

%{
PROBLEM 1 DESCRIPTION: This program analyzes a forced-convection heat exchanger consisting
of water flowing inside a thin cylindrical tube while hot gas flows across the outside in crossflow. 
The objective is to determine the required tube length needed to heat the water from 15°C to 35°C.

The code:
 1) Computes the internal convection coefficient using the
    Dittus–Boelter correlation for turbulent internal flow.
 2) Computes the external convection coefficient using the
    Churchill–Bernstein correlation for flow over a cylinder.
 3) Calculates the overall heat transfer coefficient U.
 4) Solves for the required tube length L using an energy balance.
 5) Repeats the calculations for multiple gas velocities, tube
    diameters, and hot-gas temperatures.
 6) Generates design plots of required tube length versus gas velocity
    and identifies acceptable operating regions based on length limits.
%}

clc; clear; close all;

%% ------------------ GIVEN CONSTANTS ------------------
mdot = 0.2;                % Water mass flow rate (kg/s)
cp = 4180;                 % Water specific heat (J/kg-K)
Tin = 15;                  % Water inlet temp (C)
Tout = 35;                 % Water outlet temp (C)

D = [0.02 0.03 0.04];      % Tube diameters (m)
V = [20 30 40];           % Gas velocities (m/s)
Tinf = [250 375 500];     % Hot gas temperatures (C)

% Water properties at 25 C
mu_w = 0.00089;            % Pa-s
k_w = 0.607;                 % W/m-K
Pr_w = 6.13;

% Air properties (average = 140C for external flow)
rho = 0.8542;                % kg/m^3
mu_air = 2.345e-5;           % Pa-s
k_air = 0.03374;             % W/m-K
Pr_air = 0.7041;

%% ------------------ LOOP OVER TEMPERATURES ------------------
for t = 1:length(Tinf)
    
    figure; hold on; grid on;
    
    for d = 1:length(D)
        
        L = zeros(size(V));
        
        % -------- Inside Convection (hi) --------
        Re_i = (4*mdot) / (pi*D(d)*mu_w);
        Nu_i = 0.023 * Re_i^0.8 * Pr_w^0.4;
        hi = (Nu_i * k_w) / D(d);
        
        for v = 1:length(V)
            
            % -------- Outside Convection (ho) --------
            Re_o = (rho * V(v) * D(d)) / mu_air;
            
            Nu_o = 0.3 + ...
                   (0.62 * Re_o^0.5 * Pr_air^(1/3)) / ...
                   (1 + (0.4/Pr_air)^(2/3))^(1/4) * ...
                   (1 + (Re_o/282000)^(5/8))^(4/5);
               
            ho = (Nu_o * k_air) / D(d);
            
            % -------- Overall U --------
            U = 1 / (1/hi + 1/ho);
            
            % -------- Required Length L --------
            L(v) = (mdot*cp)/(U*pi*D(d)) * ...
                   log((Tinf(t)-Tin)/(Tinf(t)-Tout));
        end
        
        % -------- Plot --------
        plot(V, L, '-o', 'LineWidth', 2);
    end
    
    yline(3,'--k','LineWidth',1.5);
    yline(6,'--k','LineWidth',1.5);
    
    xlabel('Gas Velocity V (m/s)');
    ylabel('Required Tube Length L (m)');
    title(['Tube Length vs Velocity at T_\infty = ' num2str(Tinf(t)) ' °C']);
    
    legend('D = 20 mm','D = 30 mm','D = 40 mm','Location','best');
end
