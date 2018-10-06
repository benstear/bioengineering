%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Neural Signals BMES-477/710
% Lab 1: Introduction to membrane properties
% Section 1: (Nernst) Equilibrium Potential
% Author: E.Knudsen,PhD
% Updated: C.von Reyn,PhD 01/01/2018
% Instructions: Modify parameter values as indicated in the lab handout,
% and answer questions accoringly!
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc
% Material constants:
R = 8.31; % J/molK = Coulombs * Volts / moles * degrees Kelvin
F = 96480; % C/mol = Coulombs / moles
T = 298; % in K, 25 degrees Celsius, remember: 0 C = 273 K

% internal constants:
vol_i = 1;      % inside compartment volume
vol_o = 10;      % outside compartment volume
A = 1;          % Area of membrane
P = 0.02;       % Permeability to diffusing species

% DEFINE PARAMETERS (modify these):
z = +1; % Ionic charge, e.g. potassium (K+), z = +1;
Cin = 10; % Intracellular ionic concentration (in mM)
Cout = 124; % Extracellular ionic concentration (in mM)
Vm = 60;   % Transmembrane potential in mV

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Running the simulation
% some definitions:
% Simulation time:
dt = 0.1;   % timestep in seconds
start = 0;  % in seconds
stop = 200; % in seconds

% Directly from neuron
a = A*P / vol_i; % simplifying term for inside compartment
b = A*P / vol_o; % simplifying term for outside compartment
expmxi = 1;      % if no charge moving, e.g. Vm = 0
if Vm            % if current is flowing
    xi = z * (Vm/1000) * F / (R*T);
    a = a * (xi / (1 - exp(-xi)));
    b = b * (xi / (1 - exp(-xi))) * exp(-xi);
    expmxi = exp(-xi);
end

% Now run through the calculation of Cin_new and Cout_new:
time = start:dt:stop;
Cin_new = [Cin zeros(1,length(time)-1)];
Cout_new = [Cout zeros(1,length(time)-1)];
for i = 2:length(time)
    Cin_new(i) = (Cin_new(i-1) * (1 + (dt * b)) + Cout_new(i-1) * dt * a * expmxi) ...
        /(1 + dt * (a + b));
    Cout_new(i) = Cout_new(i-1) - (Cin_new(i) - Cin_new(i-1)) * (vol_i/vol_o);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting simulation results:
figure;
plot(time,Cin_new,'r');
hold on
plot(time,Cout_new,'b');
legend('C_{in}','C_{out}')
title('Na+ with V_o = 10 and Vm = Nernst Potential ')
xlabel('Time (sec)')
ylabel('Ion Concentration (mM)')

