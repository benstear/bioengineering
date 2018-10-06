%                           %
%   Simple Neural Network   %
%                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w1 = randn();
w2 = randn();  % start w random numbers here, will improve later
b = randn();
f = @(m1, m2, w1, w2,b) (1/(m1*w1)+(m2*w2)+b);
f(1,2,w1,w2,b) % good

% now lets look at the cost function which will help our weights become
% more meaningful

