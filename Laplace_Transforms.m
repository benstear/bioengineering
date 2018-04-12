% Ben Stear
%
% This code is concerned with using symbolic notation and laplace transforms to solve differential eqns.

% use eig() to find eigenvalues.  Overdamped, critically damped or
% underdamped?
A = [0 1; -10 -2];
[v,d] = eig(A)
% critically damped because both roots are negative and equal. 
%% Question 2
% Solve matrix D.E. in Laplace domain. Find X1(s) and X2(s). 
x0 = [0;0]
% stable
A = [0 1; -10 -2]
B = [0; 1]
%  symbolic solution
syms s
Us = 1/s;  % step input
Xs = inv(s*eye(2)-A)*x0+ inv(s*eye(2)-A)*B*Us
% to get each component
X1s = simplify(Xs(1,1))
X2s = simplify(Xs(2,1))

%% Question 3
% Find inverse Laplace transform (time response) for X1(s), X2(s) and U(s).
% Use matlabFunction() to create anonymous functions of time. 
 
% now invert
x1t = ilaplace(X1s)
x2t = ilaplace(X2s)
 
IC = x0;
ep = inv(A)*-B;
%x1 = matlabFunction(x1t)
%x2= matlabFunction(x2t)
% make functions to plot
 
%% Question 4
% Plot analytical soln when t = 0:0.01:15. 
 
figure(1)
 
t = 0:0.01:10;
subplot(2,2,1)
plot(t,x1(t),'r', 'linewidth', 2)
grid on; 
ylabel('x_1(t)')
title('Component Plots')
xlabel('t')
 
subplot(2,2,3)
plot(t,x2(t), 'linewidth', 2)
title('Component Plots')
grid on; ylabel('x_2(t)')
xlabel('t')
 
%% Question 5
% Plot phase plot. Show initial conditions with black star.
subplot(1,2,2)
plot(x1(t),x2(t),'g', 'linewidth', 2)
hold on, plot(IC(1),IC(2),'b*',ep(1),ep(2),'k*')
plot(ep(1),ep(2),'ko')
hold off
xlabel('x_1(t)'), ylabel('x_2(t)')
title('Phase Plot')
legend('Analytical Trajectory','Initial Condition','Eq Point','Location','best')
grid on
 
%% Question 6
 
% 1.) The phase plot is a spiral that starts at the origin (x1(t) and x2(t)
% equal zero) and ends at (0.1,0), where x1(t)=0.1 and x2(t) returns to
% zero
 
% 2.) After the pulse is removed, x1(t) does not return to zero.  The
% equilibrium point is 0.1 which is reached after 6 seconds. 
 
% 3.) After the pulse is removed, x2(t) returns to zero after 6 seconds. 
