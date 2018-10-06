
%============================================================================%
%  HH_stimulate.m: HH system with stimulation current
%  
%     Example: HH_stimulate(10, 1, 5) 
%
%     It means: we applied a dc current in HH model, and 
%        1. current amplitude = 10 (uA/cm^2)
%        2. current duration  = 1 (ms)
%        3. delay or beginning time of current = 5 (ms)
%============================================================================%

function[]=HH_stimulate(intensity, duration, delaytime)

global   howstrong howlong delay

howstrong = intensity;  % intensity of applied current
howlong = duration;     % duration of applied current
delay = delaytime;      % delaytime (or beginning time) of applied current

T_MAX = 50;
step = 0.05;
tspan=0:step:T_MAX;

x0 =[-0.2828,  0.3208, 0.0513, 0.5841];     % steady state values after transient time 10ms
%x = [v n m h];

[t,x] = ode15s(@HH_function, tspan, x0);

v=x(:,1);
n=x(:,2);
m=x(:,3);
h=x(:,4);

figure(1)
subplot(2,1,1)
plot(t,v);
axis([0 T_MAX -20 120]); 
title(sprintf('HH MODEL with I (applied current)', num2str(howstrong)))
ylabel ('V (mV)')


for i=1:length(t)
    current(i)=inp(t(i));
end

subplot(2,1,2)
plot(t, current)
axis([0 T_MAX 0 max(current)+1]); 
xlabel ('t (ms)')
ylabel ('I (\muA/cm^2)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xdot = HH_function(t,x)

I = inp(t);

v=x(1);
n=x(2);
m=x(3);
h=x(4);


an = 0.01*(-v+10)/(exp(-0.1*v+1)-1);
bn = 0.125*exp(-v/80);

am = 0.1*(-v+25)/(exp(-0.1*v+2.5)-1);
bm = 4*exp(-v/18);

ah = 0.07*exp(-v/20);
bh = 1/(exp(-0.1*v+3)+1);

dv = I + 36*n^4*(-12-v) + 120*m^3*h*(120-v) + 0.3*(10.6-v);

dn = an*(1-n)-bn*n;
dm = am*(1-m)-bm*m;
dh = ah*(1-h)-bh*h;

xdot = [dv dn dm dh]';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I=inp(t)

global howstrong howlong delay

I = 0;

t_end  = delay+howlong;

if (t >= delay) & (t<=t_end)
   I = howstrong;
end;
