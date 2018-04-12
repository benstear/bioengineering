%
% Quatitative Systems Biology
% Micro Array Analysis
% Ben Stear      4/4/18
%%


gse = geoseriesread('/Users/dawnstear/downloads/GSE17257_series_matrix.txt');   % Series GSE17257   GPL 2529

gpl = bmes_downloadandparsegpl('GPL2529')         
% GSM432203	yeast treated with DMSO, biological rep1
% GSM432204	yeast treated with DMSO, biological rep2
% GSM432205	yeast treated with DMSO, biological rep3
% GSM432206	yeast treated with CQ, biological rep1
% GSM432207	yeast treated with CQ, biological rep2
% GSM432208	yeast treated with CQ, biological rep3
% gse = bmes_downloadandparsegse('GSE17257')
 
get(gse.Data)
d = gse.Data;
d(1:6,1:6);    % Print first 6 Probes and first 6 samples

% GSE Header information
%gse.Header
%gse.Header.Series
% Get the title of the samples
% gse.Header.Samples.title{1}
% gse.Header.Samples.title{2}
% gse.Header.Samples.title{3}   % good
% gse.Header.Samples.title{4}
% gse.Header.Samples.title{5}
% gse.Header.Samples.title{6}

% Print all of the available characteristics of the 20th sample
% gse.Header.Samples.characteristics_ch1(:,20) % exceeds matrix dim
% Print the diagnostic information of all samples
% gse.Header.Samples.characteristics_ch1(1,:)
gse.Header.Series.platform_id; % good, GPL2529
% d.rownames
% d.colnames{1}

% if exist('gpl') % isstruct('gpl')
%gpl = bmes_downloadandparsegpl('GPL2529')

% save('/Users/dawnstear/desktop/gpl.txt', 'gpl')
% 
% if ~(exist('/Users/dawnstear/desktop/gpl.txt', 'file')==2)
%     save('/Users/dawnstear/desktop/gpl.txt', 'gpl')
% end
    
    
gpl_genes = gpl.Data(:,11);   % 'gene symbol' 
gpl_probes = gpl.Data(:,1);   % gpl probe ID
gse_probes = d.rownames;       % gse probe ID

% Dr. Sacan provided a more generalized version...
% attribute = 'Enter Attribute' 
% gplprobes = gpl.Data(:, strcmp(gpl.ColumnNames, 'ID'));
% gplgenes  = gpl.Data(:, strcmp(gpl.ColumnNames, 'Gene Symbol'));

map = containers.Map(gpl_probes,1:numel(gpl_probes));
for i=1:numel(gse_probes)
	if map.isKey(gse_probes{i}); 
        MAP_GSE_GPL(i)=map(gse_probes{i}); end
end

gse_genes = gse_probes; %make a copy, so entries not found will keep the probe name.
gse_genes(find(MAP_GSE_GPL)) = gpl_genes(MAP_GSE_GPL(find(MAP_GSE_GPL)));

table(gse_probes(1:5), gse_genes(1:5),'VariableNames',{'gseprobe','gsegene'});
d = d.rownames(':',gse_genes); % now replace gseprobes with gsegenes

samplegroups = gse.Header.Samples.characteristics_ch1(1,:);
unique(samplegroups);
samplesources = gse.Header.Samples.source_name_ch1;
unique(samplesources);

d_array = single(d); % convert to numerical array and normalize


%% Data Analysis: Find differentially expressed genes between groups of samples.

                    
DMSO = d_array(:,1:3); %(d_array(:,1) + d_array(:,2) + d_array(:,3));   
CQ   = d_array(:,4:6); %(d_array(:,4) + d_array(:,5) + d_array(:,6));  

[~,pvals]=ttest2(DMSO', CQ');

% for multiple hypothesis testing, correcting p-value mafdr()
fpvals = mafdr(pvals);
% TODO: create dpvals from fpvals.

% The fold changes were calculated by ratio of signals in CQ-treated 
% samples to that in DMSO-treated controls, and presented as the averages of three experiments.
% d.rownames{6293} % CTR1
% d.rownames{4585} % VEL1 

[dpvals]=mattest(DMSO, CQ, 'permute',10);

dpvals_sorted =  sort(dpvals); 
%fprintf('Found %d genes with p-value <=0.01\n',nnz(dpvals(:,1) <= 0.01));
%fprintf('Top 5 most significantly different genes between DMSO and CQ samples:\n');
%disp(dpvals_sorted(1:5,:))

%% Plot expression levels of top 5 genes in each group
[~,Itop5]=sort(dpvals(:,1));
Itop5 = Itop5(1:5);
top5avg = zeros(5,4);
top5std = zeros(5,4);
% finish

%% Calculate fold change
log2fc = mean(DMSO,2) - mean(CQ,2);
%scatter(log2fc, -log10(dpvals(:,1)), '.');
%xlabel('log_2(DMSO:CQ)'), ylabel('-log_{10}(pvalue)');
%hold on; %mark lines for fc>=1.5 and pvalue<=0.01
%plot(log2([2/3 2/3]), ylim, log2([1.5 1.5]), ylim)
%plot(xlim, -log10([.01 .01]))

% convert log2fc to negfc
negfc = 2.^log2fc;
negfc(negfc<1) = - 1./negfc(negfc<1);


dpvals=[dpvals bioma.data.DataMatrix(negfc,'ColNames',{'negfc'})];
% Select the genes with pvalue<=0.01 and FC>=1.5.
I = dpvals(:,'p-values2')<=0.01 & abs(dpvals(:,'negfc'))>=1.5;
dsigfc = dpvals(I,:);
dsigfc = dsigfc.sortrows('p-values2');
fprintf('Found %d genes with pvalue<=0.01 and FC>=1.5. Showing top 5:\n',size(dsigfc,1));
disp(dsigfc(1:5,:))


%mavolcanoplot(DMSO, CQ, dpvals(:,1),'Labels',d.rownames)

%--------------------------------------------%
% Data Analysis: Hierarchical Clustering

%I=genevarfilter(d, 'Percentile',99); %remove 99% of genes
%d2 = d( I, :);

% make dpvals.colname(2) = 'p-values' 
% 
% genedist = pdist(d2,'corr'); 
% tree = linkage(genedist,'average');
% bmes_fig geneclust; clf
% dendrogram(tree,20,'Labels',d2.rownames);
% h=gca;
% h.XTickLabelRotation=45;
% Iclust = cluster(tree, 'maxclust', 6);
% 
% 
% bmes_fig geneclust; clf
% for i=1:6
% 	subplot(2,3, i);
% 	plot( d2(Iclust==i, :)' );
% end
% d2avg=zeros(6,size(d2,2));
% for i=1:6
% 	d2avg(i,:) = mean(d2(Iclust==i,:),1);
% end
% bmes_fig geneclust; clf
% plot(d2avg');









%% Data Analysis: Gene Set Enrichment

% 
% gplgobio  = gpl.Data(:, strcmp(gpl.ColumnNames, 'Gene Ontology Biological Process'));
% % The biological process of the first microarray probe:
% gplgobio{1};
% 
% % The Gene Ontology terms are given as a list separated by '///'. Let's
% % convert each into a cell array, to make programming with them easier.
% for i=1:numel(gplgobio)
% 	%handle empty separately, b/c strsplit doesn't work as we want for empty strings.
% 	if isempty(gplgobio{i}); gplgobio{i}={};
% 	else gplgobio{i} = strsplit(gplgobio{i},' /// '); end
% end
% 
% GOBIO = unique( [gplgobio{:}] );
% map = containers.Map(GOBIO,1:numel(GOBIO));
% for i=1:numel(gplgobio)
% 	for j=1:numel(gplgobio{i})
% 		gplgobio{i}{j} = map(gplgobio{i}{j});
% 	end
% 	gplgobio{i} = cell2mat(gplgobio{i});
% end
