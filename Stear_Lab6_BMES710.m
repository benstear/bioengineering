%
% Ben Stear
% BMES 710
% Lab 6: Auto-correlogram and the Cross-correlogram
% 3/6/18

%% Part 1. Count Entropy of the spike train.

Xmin = -.100; % s
Xmax = .100;  % s
bin = .001;   % s
response1 = PSTHdata{1}; % neuron1 spike times
response2 = PSTHdata{2}; % neuron2 spike times
stimulus1 = PSTHdata{3}; % reference stim L1 times
stimulus2 = PSTHdata{4}; % reference stim L2 times
%% Find distances for all 4 cases
d11 = zeros(1497,116); % neuron1 & stim1,   116 trials
for j = 1:length(response1) 
    for k = 1:length(stimulus1) 
    d11(j,k) = response1(j) - stimulus1(k);
    end 
end
d12 = zeros(1497,116); % neuron1 & stim2,    116 trials
for j = 1:length(response1)
    for k = 1:length(stimulus2)
    d12(j,k) = response1(j) - stimulus2(k);
    end
end
d21 = zeros(7130,116); % neuron2 & stim1,     116 trials
for j = 1:length(response2)
    for k = 1:length(stimulus1)
    d21(j,k) = response2(j) - stimulus1(k);     
    end
end
d22 = zeros(7130,116); % neuron2 & stim2,    116 trials
 for j = 1:length(response2)
    for k = 1:length(stimulus2)
    d22(j,k) = response2(j) - stimulus2(k); 
    end
 end
% create psth's
psth1 = histc(d11,Xmin:bin:Xmax)/length(stimulus1); 
psth2 = histc(d12,Xmin:bin:Xmax)/length(stimulus2);
psth3 = histc(d21,Xmin:bin:Xmax)/length(stimulus1);
psth4 = histc(d22,Xmin:bin:Xmax)/length(stimulus2);

% a.
% H = Entropy, we only need p[r|s] for entropy although it will be different
% for EC and ET. we'll need p[r] and p[s] for MI


% I like dealing with the matrices in dim 116x201 instead of 201x116
Prs1 = psth1'; Prs2 = psth2'; Prs3 = psth3'; Prs4 = psth4';

Prs1 = Prs1>0;  % turn values that arent 0 into 1
Prs1 = Prs1(:,101:140); % extract first 40 bins
countTotalsPrs1 = sum(Prs1,2); %row summation = sum(A,2)

% for the 2nd, 3rd and 4th P[r|s]'s repeat process
Prs2 = Prs2>0; Prs2 = Prs2(:,101:140); countTotalsPrs2 = sum(Prs2,2); 
Prs3 = Prs3>0; Prs3 = Prs3(:,101:140); countTotalsPrs3 = sum(Prs3,2);     
Prs4 = Prs4>0; Prs4 = Prs4(:,101:140); countTotalsPrs4 = sum(Prs4,2); 

% initialize unique counting totals
count0 = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0; 

for i = 1:length(countTotalsPrs1) % find unique counting totals
    if countTotalsPrs1(i) == 0
    count0 = count0 + 1;
    elseif countTotalsPrs1(i) == 1
    count1 = count1 + 1;
    elseif countTotalsPrs1(i) == 2
    count2 = count2 + 1;
    elseif countTotalsPrs1(i) == 3
    count3 = count3 + 1;
    elseif countTotalsPrs1(i) == 4
    count4 = count4 + 1;
    elseif countTotalsPrs1(i) == 5
    count5 = count5 + 1;
    elseif countTotalsPrs1(i) == 6
    count6 = count6 + 1;
    end
end
% find probabilities by dividing by total number of trials, 116
Prob0 = count0/116; Prob1 = count1/116; Prob2 = count2/116;
Prob3 = count3/116; Prob4 = count4/116; Prob5 = count5/116; Prob6 = count6/116; 
% E = - SUM P[r|s]*log2(P[r|s])
Ec_1 = (-1)*(Prob0*log2(Prob0) + Prob1*log2(Prob1) + Prob2*log2(Prob2) +...
             Prob3*log2(Prob3) + Prob4*log2(Prob4) + Prob5*log2(Prob5) + Prob6*log2(Prob6));

% Now do the same thing for Ec_2, Ec_3 and Ec_4.....
count0 = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0; 

for i = 1:length(countTotalsPrs2)  % Ec_2
    if countTotalsPrs2(i) == 0
    count0 = count0 + 1;
    elseif countTotalsPrs2(i) == 1
    count1 = count1 + 1;
    elseif countTotalsPrs2(i) == 2
    count2 = count2 + 1;
    elseif countTotalsPrs2(i) == 3
    count3 = count3 + 1;
    elseif countTotalsPrs2(i) == 4
      count4 = count4 + 1;  
    end
end   
Prob0 = count0/116; Prob1 = count1/116; Prob2 = count2/116;
Prob3 = count3/116; Prob4 = count4/116;

Ec_2 = (-1)*(Prob0*log2(Prob0) + Prob1*log2(Prob1) + Prob2*log2(Prob2) +...
             Prob3*log2(Prob3) + Prob4*log2(Prob4));

for i = 1:length(countTotalsPrs3) % Ec_3
    if countTotalsPrs3(i) == 0
    count0 = count0 + 1;
    elseif countTotalsPrs3(i) == 1
    count1 = count1 + 1;
    elseif countTotalsPrs3(i) == 2
    count2 = count2 + 1;
    elseif countTotalsPrs3(i) == 3
    count3 = count3 + 1;
    elseif countTotalsPrs3(i) == 4
    end
end   
Prob0 = count0/116; Prob1 = count1/116; Prob2 = count2/116;
Prob3 = count3/116; Prob4 = count4/116;
Ec_3 = (-1)*(Prob0*log2(Prob0) + Prob1*log2(Prob1) + Prob2*log2(Prob2) +...
             Prob3*log2(Prob3) + Prob4*log2(Prob4));
         
count0 = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0; 
count8 = 0; count11 = 0; % reset counts

for i = 1:length(countTotalsPrs4) % Ec_4
    if countTotalsPrs4(i) == 0
    count0 = count0 + 1;
    elseif countTotalsPrs4(i) == 1
    count1 = count1 + 1;
    elseif countTotalsPrs4(i) == 2
    count2 = count2 + 1;
    elseif countTotalsPrs4(i) == 3
    count3 = count3 + 1;
    elseif countTotalsPrs4(i) == 4
    count4 = count4 + 1;
    elseif countTotalsPrs4(i) == 5
    count5 = count5 + 1;
    elseif countTotalsPrs4(i) == 6
    count6 = count6 + 1;
    elseif countTotalsPrs4(i) == 8
    count8 = count8 + 1;
    elseif countTotalsPrs4(i) == 11
    count11 = count11 + 1;
    end
end

Prob0 = count0/116; Prob1 = count1/116; Prob2 = count2/116;
Prob3 = count3/116; Prob4 = count4/116; Prob5 = count5/116; 
Prob6 = count6/116; Prob8 = count8/116; Prob11 = count11/116;

Ec_4 = (-1)*(Prob0*log2(Prob0) + Prob1*log2(Prob1) + Prob2*log2(Prob2) +...
             Prob3*log2(Prob3) + Prob4*log2(Prob4) + Prob5*log2(Prob5) +...
             Prob8*log2(Prob8) + Prob11*log2(Prob11));
         
% COUNT ENTROPY: Ec_1 = 2.4420,  Ec_2 = 1.6366,  Ec_3 = 1.2893,  Ec_4 = 2.2092
        

% b. Find Time entropy and Find P[r]  
Stimulus = [stimulus1; stimulus2]; % Concatenate the two stim trains 
bin5 = .005;                       % define new bin size

d1 = []; % create new psth's with concatenated stimulus vector
for j = 1:length(response1) 
    for k = 1:length(Stimulus) 
    d1(j,k) = response1(j) - Stimulus(k);
    end 
end

 d2 = []; 
for j = 1:length(response2) 
    for k = 1:length(Stimulus) 
    d2(j,k) = response2(j) - Stimulus(k);
    end 
end
psth1 = histc(d1,Xmin:bin5:Xmax)/length(Stimulus);
psth2 = histc(d2,Xmin:bin5:Xmax)/length(Stimulus);
Pr1 = psth1';         % put in dimension 232x41
Pr1 = Pr1>0;          % if there was a spike, make value = 1
Pr1 = Pr1(:,21:28);   % take only first 8 bins

% same thing for neuron 2 response
Pr2 = psth2'; Pr2 = Pr2>0; Pr2 = Pr2(:,21:28);

% now find unique sequences
Pr1_sort = sortrows(Pr1); % sort by row and count manually 
Pr2_sort = sortrows(Pr2);

Et_1 = (-1)*((-.0339*6)+(-.0591*4)+  (-.0811*3) + (4/232)*log2(4/232)+...
    (6/232)*log2(6/232) + (7/232)*log2(7/232) + (9/232)*log2(9/232)+...
    (73/232)*log2(73/232) + (23/232)*log2(23/232)+ (35/232)*log2(35/232)+...
    (57/232)*log2(57/232)); % Et_1 = 3.0194

Et_2 = (-1)*( (-.0339*26) + (-.0591*2) + (-.0811)+(-.1010*2)+(-.1193)+...
            (6/232)*log2(6/232) + (7/232)*log2(7/232)+(12/232)*log2(12/232)...
                +(41/232)*log2(41/232)); % Et_2 = 2.3537


Ps = 0.5; % P[s] = 0.5

% c.  

% d. I think the time entropy, E_t, would decrease if we selected a bin
% size smaller than 5ms. I think this because entropy, at least for
% information theory, is a measure of uncertainty. So, if we use smaller
% bin sizes, this will give us better temporal resolution and hence less
% uncertainty.

%% Part 2 Mutual Information


% a) Find joint COUNT Mut. Info. take first 40ms of countTotalsPrs1/2/3/4
% compare sequence of counts 
S1 =  [countTotalsPrs1 countTotalsPrs3]; % both neurons response to stim 1
S2 =  [countTotalsPrs2 countTotalsPrs4];% both neurons response to stim 2

% MIc is these summed
% MIt is same thing but with unique sequence totals from Pr1 and Pr2

S1_sorted = sortrows(S1); % Mc1, sort by row and count manually
S2_sorted = sortrows(S2);% Mc2,


% concatenated stim matrix
Stmulus;
Pr12 = [Pr1_sort Pr2_sort];


