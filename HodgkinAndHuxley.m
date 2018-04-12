% Single Neuron Model %


%Default Parameters%

I = 10;    % External input (current)
a = 0.02;  % sets recovery rate of u
b = 0.2;   % sensitivity of recovery
c = -65;   % after spike reset value for v
d = 8;     % after spike reset value for u

% Initial Values for u and v %

v = -65; % membrane potential
u = b*v; % generic recovery variable, feeds back negatively onto v

% Initialize the vector that will contain the membrane potential

v_tot = zeros(1000,1);

for t = 1:1000
    % set v_tot at this time point to the current value of v
    v_tot(t) = v;
    
    % reset v and u if v crosses threshold. Eq 29.3
    if(v>=30)
        v=c;
        u = u+d;
    end;
    
    % Use Eulers Integration Method
    v = v + 0.5*(0.04*v&circ;2+5*v+140-u+I);
    v = v + 0.5*(0.04*v&circ;2+5*v+140-u+I);
    u = u + a*(b*v-u);
end;
    
v_tot(find(v_tot>=30)) = 30;
plot(v_tot);
    
    
    
    
    