%
% Ben Stear
% BMES 710
% Lab 6: Auto-correlogram and the Cross-correlogram
% 3/6/18

% Part 1. Entropy of the spike train.
% Use your dataset to estimate the entropy of the spike train for 
% neuron 1 and neuron 2 for the two stimuli. To estimate the entropy,
% consider a post-stimulus window of 40 ms.

response1 = PSTHdata{1};  % neuron1 spike times
response2 = PSTHdata{2};  % neuron2 spike times
stimulus1 = PSTHdata{3}; % reference stim L1 times
stimulus2 = PSTHdata{4}; % reference stim L2 times


%  Extract PSTHdata and put it into vectors so its easier to work with 
ts1 = PSTHdata{1}; % zeros(1497,1); % neuron1 spike times
ts2 = PSTHdata{2}; % zeros(7130,1); % neuron2 spike times
ref1 = PSTHdata{3}; % zeros(116,1); % reference stim L1 times
ref2 = PSTHdata{4}; % zeros(116,1); % reference stim L2 times



%% Find distances for all 4 cases

d11 = zeros(1497,116); % neuron1 & stim1,   116 trials
for j = 1:length(ts1) 
    for k = 1:length(ref1) 
    d11(j,k) = ts1(j) - ref1(k);
    end 
end

d12 = zeros(1497,116); % neuron1 & stim2,    116 trials
for j = 1:length(ts1)
    for k = 1:length(ref2)
    d12(j,k) = ts1(j) - ref1(k);
    end
end

d21 = zeros(7130,116); % neuron2 & stim1,     116 trials
for j = 1:length(ts2)
    for k = 1:length(ref1)
    d21(j,k) = ts2(j) - ref1(k);     
    end
end

d22 = zeros(7130,116); % neuron2 & stim2,    116 trials
 for j = 1:length(ts2)
    for k = 1:length(ref2)
    d22(j,k) = ts2(j) - ref2(k); 
    end
 end
 
 Vector_d11 = reshape(d11,[173652 1]); % reshaping into a nx1 vector 
 Vector_d12 = reshape(d12,[173652 1]); % made the PSTHs look better 
 Vector_d21 = reshape(d21,[827080 1]); % for some reason
 Vector_d22 = reshape(d22,[827080 1]);

% d11[] or psth[] ?

% a. Estimate the count entropy EC (entropy obtained representing the
%    responses of the neuron as the total number of spikes emitted in the
%    post-stimulus window) for the two neurons for both stimuli.

% H = Entropy, we only need p[r|s] for entropy although it will be different
% for EC and ET. we'll need p[r] and p[s] for MI

% P[r|s]: The probability of response r being recorded given that 
%         a particular stimulus s was presented



% b. Estimate the timing entropy ET using a binsize of 5ms.