%
%
%
% Probability Density Functions
% Continuous Random Variables

% https://www.youtube.com/watch?v=szjL60gAweE

% Average time waiting on the phone is n min(s),
% Waiting times can be modeled with an exponential pdf:

syms t
n = 6;
%pdf = piecewise(t<0, 0, t>=0, (1/n)*exp(-(1/t))); % n is mean/ave of probability density/distribution
pdf = (1/n)*exp(-(1/t));

%pdf = piecewise(x < 0, -1, 0 < x, 1)
%Evaluate y at -2, 0, and 2 by using subs to substitute for x. 
%Because y is undefined at x = 0, the value is NaN.
%subs(y, x, [-2 0 2])

% 1) Whats the probability your call is answered in the first k minutes?
% p(0<x<k) = integral of pdf w.r.t 't' with lim's of integration of 0 and k
% ans: .2835 or a 28.35% chance your call gets answered after 2min.

% 2) What about prob. that you'd have to wait atleast 2 min for call to
% be answered?
% p(x<=2) = integral of pdf wrt t, lims of integration is 2 and Inf.

%fun = @(t) piecewise(t<0, 0, t>=0, (1/n)*exp(-(1/t)));
fun = @(t) (1./n)*exp(-(1./t));
q = integral(fun,0,2)  % .1089

% birthday paradox
% 3 doors paradox
