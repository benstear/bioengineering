
% problem 1 first order ODE

% function rk = f(t,y)
% mass = 80;
% g    = 9.81;
% rk   = -g+ (4/15)*((y^2)/mass);
% end



% problem 2: 2nd order ODE

function rk2 = odePracticeFcn(t,y)

mass = 80;
g = 9.81;

rk = [ y(2);              % y(2) = y'    or  x1 = y'
-g+(4/15)*y(2).^2/mass];  % z' = y''     

end