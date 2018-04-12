%
% Ben Stear
% BMES 710
% Lab 4: Peri-Stimulus Time Histogram
% 2/21/18
%

%% Part 1 

%  Extract PSTHdata and put it into vectors so its easier to work with 
ts1 = PSTHdata{1}; % zeros(1497,1); % neuron1 spike times
ts2 = PSTHdata{2}; % zeros(7130,1); % neuron2 spike times
ref1 = PSTHdata{3}; % zeros(116,1); % reference stim L1 times
ref2 = PSTHdata{4}; % zeros(116,1); % reference stim L2 times

% Find distances for all 4 cases

d11 = zeros(1497,116); % neuron1 & stim1
for j = 1:length(ts1) 
    for k = 1:length(ref1) 
    d11(j,k) = ts1(j) - ref1(k);
    end 
end

d12 = zeros(1497,116); % neuron1 & stim2
for j = 1:length(ts1)
    for k = 1:length(ref2)
    d12(j,k) = ts1(j) - ref2(k);
    end
end

d21 = zeros(7130,116); % neuron2 & stim1
for j = 1:length(ts2)
    for k = 1:length(ref1)
    d21(j,k) = ts2(j) - ref1(k);     
    end
end

d22 = zeros(7130,116); % neuron2 & stim2
 for j = 1:length(ts2)
    for k = 1:length(ref2)
    d22(j,k) = ts2(j) - ref2(k); 
    end
 end
 
 Vector_d11 = reshape(d11,[173652 1]);
 Vector_d12 = reshape(d12,[173652 1]);
 Vector_d21 = reshape(d21,[827080 1]);
 Vector_d22 = reshape(d22,[827080 1]);
 
% Determine which bin each value falls into and create PSTH  
 
Xmin = -.100; % s
Xmax = .100;  % s
bin = .001;   % s
 
subplot(2,2,1)
psth = histc(Vector_d11,Xmin:bin:Xmax)/length(ref1); %to generate your PSTH 
bar(Xmin:bin:Xmax,psth,'histc'); %to plot your PSTH
title('Neuron 1 & Stimulation L1'), axis('tight')
ylabel('Spikes per Bin'), xlabel('Bins  DeltaT = 1 ms')
xlim([-.1 .1]), ylim([0 0.5])

subplot(2,2,2)
psth = histc(Vector_d12,Xmin:bin:Xmax)/length(ref2); 
bar(Xmin:bin:Xmax,psth,'histc');
title('Neuron 1 & Stimulation L2'), axis('tight')
ylabel('Spikes per Bin'), xlabel('Bins  DeltaT = 1 ms')
xlim([-.1 .1]), ylim([0 0.5])

subplot(2,2,3)
psth = histc(Vector_d21,Xmin:bin:Xmax)/length(ref1);  
bar(Xmin:bin:Xmax,psth,'histc');
title('Neuron 2 & Stimulation L1'),axis('tight')
ylabel('Spikes per Bin'), xlabel('Bins  DeltaT = 1 ms')
xlim([-.1 .1]), ylim([0 0.5])

subplot(2,2,4)
psth = histc(Vector_d22,Xmin:bin:Xmax)/length(ref2);
bar(Xmin:bin:Xmax,psth,'histc'); 
title('Neuron 2 & Stimulation L2'),axis('tight')
ylabel('Spikes per Bin'), xlabel('Bins  DeltaT = 1 ms')
xlim([-.1 .1]), ylim([0 0.5])

% b) It looks like the first three cases are reacting but the 4th 
%  (neuron 2 with stimulus 2) does not look like its responding.

%% Part 2

% get psth's (with distances in matrix form)
psth11 = histc(d11,Xmin:bin:Xmax)/length(ref1);  
psth12 = histc(d12,Xmin:bin:Xmax)/length(ref1);
psth21 = histc(d21,Xmin:bin:Xmax)/length(ref2);
psth22 = histc(d22,Xmin:bin:Xmax)/length(ref2);
 

%find sum of each col (bincounts), find average of this for -100 to -5
bincounts1 = [];
    for i = 1:201  % from -100ms to -5ms
        bincounts1(i) = sum(psth11(i,:));
    end
   background1 =  (sum(bincounts1(1:95)))/95; % divide by num of bins we're summing
   THRESHOLD1 = background1 + 3*std(bincounts1); % calculate threshold
   
   bincounts2 = []; % for neuron 1 with stim2
    for i = 1:201  
        bincounts2(i) = sum(psth12(i,:));
    end
   background2 =  (sum(bincounts2(1:95)))/95; 
   THRESHOLD2 = background2 + 3*std(bincounts2); 
   
   bincounts3 = []; % for neuron 2 with stim2
    for i = 1:201  
        bincounts3(i) = sum(psth21(i,:));
    end
   background3 =  (sum(bincounts3(1:95)))/95;
   THRESHOLD3 = background3 + 3*std(bincounts3); 
   
   bincounts4 = []; % for neuron 1 with stim2
    for i = 1:201  % from -100ms to -5ms
        bincounts4(i) = sum(psth22(i,:));
    end
   background4 =  (sum(bincounts4(1:95)))/95; % divide by num of bins were summing
   THRESHOLD4 = background4 + 3*std(bincounts4); % calculate threshold
   
   
% find highest probability bin
PeakResponse1 = max(bincounts1); % 0.4828 (111)
PeakResponse2 = max(bincounts2); % 0.1293 (114)
PeakResponse3 = max(bincounts3); % 0.1379 (112)
PeakResponse4 = max(bincounts4); % 0.0776 (118)

% find response magnitude
responseMag1 = sum(bincounts1(110:115)); % 1.7328
responseMag2 = sum(bincounts2(113:115)); % .3190
responseMag3 = sum(bincounts3(111:115)); % 0.517
responseMag4 = sum(bincounts4(111:115)); % No significant response
   
% plot values   
Neurons = {'Neuron1 (Stim1)'; 'Neuron1 (Stim2)';...
           'Neuron2 (Stim1)'; 'Neuron2 (Stim2)'};
       
RM = [1.732;0.319;0.517;0];
PR = [0.4828;0.1293;0.1379;0.0776];
FBL = [0.013;0.013;0.011;-0.032];
LBL = [0.015;0.017;0.017;0.018];
PL = [0.011;0.014;0.012;0.018];

% a)
T = table(Neurons,RM,PR,FBL,LBL,PL)

% b) I think these values all make sense, there was no significant
%response for neuron2/stim2 and that is reflected in the table. 
% Also, for neuron2/stim2 the first significant bin looks like it
% occurs before t = 0 which is also reflected in the table.

% c) I think I would use FBL, LBL and PL. I would determine if the peak
% latency fell between the FBL and LBL then it is likely the neuron
% responded.

% d) If we raise the value of k then our threshold will be higher and it
% will take a higher peak to be classified as a spike. It could reduce our
% response magnitube.

% e) I think that a value of k greater than zero will give you better
% results by filtering the background activity out better.
       





   
   