% This is some code for an integrate and fire model of a neuron. This is NOT my code, although we used it extensively.

%%%% Integrate-and-Fire Model %%%%%
%
% ion channels = resistance
% lipid bilayer = capacitance
% V_m = V_i - V_o,  MemPot = Vin - Vo
% Vss = E + R*I,    E = Vss   I = injected current  R = (membrane) resistance
% Tau = TC = R*C,  C = (membrane) capacitance
% Eqn to solve:  Tau*V' = Vss - Vo, where Vss = E (or) Vss = E + IR
% Soln:   V(t) = Vss - (Vss - Vo)e^(-t/Tau)

% Assume Vrest = E_l,   E_l =  leak channels (aka only leak channels are
% open) so E_l is = Vrest

clear all; % clear variables
close all; % close figures


% DEFINE PARAMETERS
dt      = 0.1; % time step [ms]
t_end   = 500; % total runtime [ms]
t_StimStart = 100; % time to start injecting 
t_StimEnd  = 400; % time to stop  injecting
E_L     = -70; % resting membrane potential [mV]
V_th    = -55; % spike threshold [mV]
V_reset = -75; % reset value [mV]
V_spike =  20; % height of spike
R_m     =  10; % membrane resistance [mOhms]
tau     =  10; % time constant [ms]

% Specifying that both sides of the eqn have the same units is crucial
% Now lets specify parameters at t = 0, aka ICs

%% PART I: Subthreshold Dynamics

t_vect = 0:dt:t_end; % holds vector of times
V_vect = zeros(1,length(t_vect)); % holds vector voltage

i = 1;
V_vect(i) = E_L; % V(t=0) = E_L

% INTEGRATE tau*dV/dt = -V + E_L + I_e * R_m

% I_e_vect = zeros(1,length(t_vect)); % injected current [nanoAmps]

I_Stim = 1.55; %magnitude of pulse of injected current [nA]
I_e_vect = zeros(1,t_StimStart/dt); %portion of I_e_vect from t=0 to t=t_StimStart 
I_e_vect = [I_e_vect I_Stim*ones(1,1+((t_StimEnd-t_StimStart)/dt))]; %add portion from
% t=t_StimStart to t=t_StimEnd 
I_e_vect = [I_e_vect zeros(1,(t_end-t_StimEnd)/dt)]; %add portion from t=t_StimEnd to t=t_end

for t = dt:dt:t_end % start at dt not 0 bc our ICs are at t=0
    
    V_inf = E_L + I_e_vect(i)*R_m; %  value that V_vect is exp. decaying towards, V_inf is Vss
                                    % 
    V_vect(i+1) = V_inf + (V_vect(i)-V_inf)*exp(-dt/tau);
    
    %if statement below says what to do if voltage crosses threshold
    if (V_vect(i+1) > V_th) %cell spiked
    V_vect(i+1) = V_reset; %set voltage back to V_reset
    end
    
    i = i+1;
end

%MAKE PLOTS figure(1)
plot(t_vect, V_vect);
title('Voltage vs. time'); 
xlabel('Time in ms'); 
ylabel('Voltage in mV');

% However, you are probably wondering, ?Where are the beautiful spikes going up to some high voltage?? 
% Well, in truth, the integrate- and-fire model never really assigns a voltage above V_th.
% Every time threshold is reached, it immediately resets the voltage to V_reset (which is our signal
% that a spike occurred at this time, if we were trying to count the number of spikes).


