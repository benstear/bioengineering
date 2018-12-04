
% Ben Stear 

%% PART 1) Reproduce non-linear logistic equation from lecture slide #14

r=linspace(2.0,3.9,1000);
c=1000;
figure
hold on
for i=1:length(r)
   x(1)= .1;
   for n=1:c-1
       x(n+1)=r(i)*x(n)*(1-x(n));
       if(n>0.9*c); plot(r(i),x(n),'r.','MarkerSize',1); end
   end
end
title('Discrete Logistic Equation'); xlabel('r'); ylabel('x');


%% Part 2) Carrying capacity equation
r = 1.0;
k = 5;
N = zeros(1,10);
N(1) = .2;
for t=1:10
    N(t+1) = (N(t)) * exp(r*(1-(N(t)/k)));
end
figure
plot(1:11,N,'LineWidth',2)
title('Carrying Capacity Equation (r = 1.0, k = 5.0)'); xlabel('t'); ylabel('population');

