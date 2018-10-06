%
%
%   coding ideas:
% Taylor/Power Series
% 



w1 = 2;
w2 = 0.5;
n = 10;
sigSumVector = [0 0 0 0 0 0 0 0 0 0];

for i = 1:n
    
    p1 = rand(1);
    p2 = rand(1);
    mysum = p1*w1 + p2*w2;
    sigSum = 1/(1+(exp(-mysum)));  % activation f(), (sigmoid)
    sigSumVector(i) = sigSum;
    sigSumMean = sum(sigSumVector)/n
    
    if sigSumMean >= 0.75
        disp('Action Potential!')
    end
    
end