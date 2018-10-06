% Ben Stear 
% Normalization Assignment
%
%

x = [
5    4    3
2    1    4
3    4    6
4    2    8
];

%% Mean Norm


function MeanNorm = y1(x)
    xnew = x; % keep raw data safe
    for i = 1:size(x,2) % number of columns
        colsums = sum(x) ; 
        xnew(:,i) = x(:,i)/colsums(i);
    end
    MeanNorm = xnew;
end


%% z-normalization


function znorm = y2(x)

xnew = x; % save raw data
colmeans = mean(x); % find column averages 
colstds = std(x);   % find column std's

    for i = 1:size(x,2) 
        xnew(:,i) = (x(:,i)-colmeans(i))/ colstds(i);
    end
    % check that mean of each column is 0 and std is 1
    if ~all(mean(xnew)) && all(std(xnew)); disp('Correct')
    else; disp('Incorrect')
    end
    znorm = xnew;
    
end


%% Quantile normalization 


function QuantileNorm = y3(x)

    xsort = x;
    for i = 1:size(x,2)   %num columns
        xsort(:,i) = sort(xsort(:,i)); % sort each column
    end

    ranknums = sum(xsort,2)/size(xsort,2); % rowsum / numofcols
    ranknums = sort(ranknums);
    % ranknums'  =  2.0000    3.0000    4.6667    5.6667

    xnew=x;
    for j = 1:size(x,2) % num columns
        [~,xnew(:,j)] = sort(xnew(:,j)); % reconstruct xnew with ranks (1-4)
    end

    for k = 1:size(x,2)
        for m = 1:size(x,1)
        c = xnew(m,k); % find what rank (1-4) current index is
        xnew(m,k) = ranknums(c); % replace that index with ranknums(c),  (ranknums is sorted)
        end
    end

    QuantileNorm = xnew;
    
end



%% Rank Normalization 


function RankNorm = y4(x)
    xnew = x;
    for i=1:size(xnew,1)
            R = max(xnew(i,:)); 
            for j = 1:size(xnew,2)
            r = xnew(i,j);  
            xnew(i,j) = (r-1)/(R-1);
            end
    end
    
    RankNorm = xnew;
end

