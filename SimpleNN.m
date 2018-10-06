%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          %
%  Simple Neural Network   %
%                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


training_set_inputs = [0 0 1; 1 1 1; 1 0 1; 0 1 1];
training_set_outputs = [0 1 1 0]';
synaptic_weights = 2*rand(3,1) -1;
% use a sigmoid (or logistic) curve/function to normalise or squeeze
% our output value into some region between 0 and 1.
n = 10000;
% bias/threshold raises the activation # from 1 to something higher/lower
% if you want threshold to be 10, throw in a -10 into the sigmoid fxn.
% 'Learning' = finding the correct weights and biases for each node in each
% layer. ReLu is used now instead of sigmoid.

% 'Stochastic gradient descent' is the learning algorithm

% percepton neurons/networks use the step function as its ACTIVATION
% FUNCTION while a sigmoid neuron uses the siqmoid function as its
% activation function

% to start off, you can randomize the weights, and biases
% a Cost function tells your network, bad network! the answer should be this
% not that.  Cost function is mean square error.

% GRADIENT DESCENT = take negative of the gradient to find the downhill
% direction we need to move to find a local (hopefully maximum)
% minimum of the cost (error) function

% the algorithm for computing the gradient efficiently is called 'Back
% Propogation' and is the heart of neural networks.

% Percepton or sigmoid network algorithms are from the 80s,
% Convolutional NN and LSTM are more powerful

% stochastic gradient descent is the drunken man walkdown the gradient,
% regular gradient descent is slower, much more computation but it is exact
%  stochastic is much faster, less computation, uses minibatches. 

for i = 1:n
    
    for jj = 1:length(training_set_inputs) 
        
        
       rowsum = dot(training_set_inputs(jj,:),synaptic_weights);
    %output = 1/(1 + exp(-(dot(training_set_inputs,synaptic_weights))));
    
    
    end 
end