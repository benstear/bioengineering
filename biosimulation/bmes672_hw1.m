%% Ben Stear   BMES 672  Homework #1
% 
%
%% PART 1

%% 1)

%% 2)
n = 1:10;

% a) 
x_2a = power(2,n)+power(3,n);
semilogy(n,x_2a,'*-');
hold on

% b)
x_2b = power(4,n); 
semilogy(n,x_2b,'*-');

% c)
x_2c = power((-1),n);
semilogy(n,x_2c,'*-');

% d)
x_2d = power(2,n);
semilogy(n,x_2d,'*-');

% e)
x_2e = power(-2,n);
semilogy(n,x_2e,'*-');

% f)
xlabel('n')
ylabel('growth')

hold off;




%% 7)
% a)
A = [3 2;1 4];
[V,D]=eig(A)

%% b)
A = [1/4 1;3/16 -1/4];
[V,D]=eig(A)

%% c) ?

%% d)
A = [1 1; 2 1];
[V,D]=eig(A)

%% e) 
A = [-1 3; 0 1/3];
[V,D]=eig(A)

%% f)
A = [1/4 3;-1/8 1];
[V,D]=eig(A)


%% PART 2 Discrete time model with one variable
% Model the geometric equation
% x(n+1) = r * x(n)

time_steps = 40;
r_low = -2; r_high = 2; num_r_trials = 20;
r = linspace(r_low,r_high,num_r_trials);
x = zeros(1,time_steps);
x(1) = 1; 

r_curves = zeros(num_r_trials,time_steps); % save values in here to plot later
r_curves(:,1) = 1; % set initial value for every 'r' trial 

for i=1:length(r)
    for n = 2:time_steps
        r_curves(i,n) = r(i)*x(n-1);
        x(n)= r(i)*x(n-1);
    end
end

colorVec = hsv(num_r_trials);
figure
hold on

for j=1:length(r)
    plot(1:time_steps,r_curves(j,:),'Color',colorVec(j,:)); 
end

xlabel('Time Steps')
ylabel('X(n)')



