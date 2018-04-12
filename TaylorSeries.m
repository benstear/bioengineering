% 
% Ben Stear
% A few problems dealing with Taylor Series
%
%
clear; close all;


% Problems
 
% 1)   f(x) = ln(1+x)

% a
syms x
f = log(1+x);
approx_f = taylor(f);

% b
approx_o12 = taylor(f, 'order', 12);
%c
approx_a3 = taylor(f, 'expansionpoint', 3); % a = 3;
%d
approx_a5 = taylor(f, 'expansionpoint', 5); % a = 5;


% 2) f(x) = exp(x)sin(x)

%a)
syms x
g = exp(x).*sin(x);
approx_t = taylor(g, x);

%b)
approx_k = taylor(g, x, 'order', 8);
%c)
approx_m = taylor(g, x, 'expansionpoint', 1); 

% Dr. T and I tried to debug this one ^ but we could not 
% figure it out...

% d) 

tayplot = ezplot(approx_t,[-6, 6, -15, 15]);
hold on

tayplot2 = ezplot(approx_k,[-6, 6, -15, 15]);
hold on

tayplot3 = ezplot(approx_m,[-6, 6, -15, 15]);

title('f(x) = exp(x)*sin(x) and its approximations')
legend('exp(x)sin(x)','8th order approximation','approximation at a = 1')
xlabel('x')
ylabel('f(x)')

% e) 
%  the plot for b, the 8th order approximation is better than
%   the standard 5th order and the plot for c has been shifted to
%  expand around 1.

% 3)

% a)
syms t
alpha = 7.25;
beta = 3.00;
gamma = 6.154;
FT = 0.36;

v = alpha*beta*exp(-gamma*t)*(1-(t/FT))*t;
approx_v = taylor(v);
% 
%  b)
approx_vo8 = taylor(v,'order',8);
approx_vo10 = taylor(v,'order',10);

% c)      
figure
aortic = ezplot(approx_v, [-.25 1.5 -1 2]);
set(aortic,'color','black')
hold on

aortic2 = ezplot(approx_vo8, [-.25 1.5 -1 2]);
set(aortic2,'color','blue')

aortic3 = ezplot(approx_vo10, [-.25 1.5 -1 2]);
set(aortic3,'color','red')

axis tight
title('Aortic Blood Flow Velocity')
legend('Aortic Velocity Function','Function Order 8','Function order 10')
xlabel('x')
ylabel('f(x)')

% d)  

% The higher the polynomial, the higher degree of accuracy in the
% approximation and the further out from x = 0 the approximation will
% better follow the actual function.

