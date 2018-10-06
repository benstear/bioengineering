% practice with odes %

% problem 1
% timerange        = [0 30]; %seconds
% initialVelocity  = 0;
% [t,y] = ode45(@odePracticeFcn, timerange, initialVelocity)
% plot(t,y);
% ylabel('velocity (m/s)');
% xlabel('time (s)');


% problem 2: 2nd order ODE

timerange = [0 15];
initialvalues = [600 0]; % match these to the vector in the fcn, [y,y']
                                                        % [position,velocity]
[t,y] = ode45(@odePracticeFcn,timerange,initialvalues);
plot(t,y(:,1))
ylabel('height (m)')
xlabel('time (s)')
