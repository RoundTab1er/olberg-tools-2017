%% Plot Results From Wave_clus
% Author: Nicholas Garcia
% Version: 2017-07-19


%% User Configurable Variables
% There is one configurable variable: the block id ('B' plus the number
% of the block) to be processed.

    %channel to graph
    channel_id = 'C4';

    %block to graph
    block = 'B17';
    
    %cluster to graph (1, 2, 3, etc)
    cluster_num = 1;
    
    %file to graph
    file_name = '2017-07-06-c-trimmed_processed';
    

%% Script
    
    %load file
    load(file_name);

    %block to process
    block_id = [channel_id block];
    
    %calculate row that contains target block data:
    %  - create array to hold variable names
    %  - convert each variable name to char vector and copy to temp array
    %    so it can be searched
    
    %create arrays
    array_size = size(block_data, 1);
    temp_array{array_size, 1} = {};

    %convert to char vector and copy over
    for idx = 1:array_size
        temp_array{idx, 1} = char(block_data{idx, 5});
    end

    %find row that contains target block data
    block_idx = find(ismember(temp_array, block_id));

    
%create figure    
results = figure;

%get axis scale
intra_block_size = block_data{block_idx, 3} - block_data{block_idx, 2} + 1;

%preallocate array for cluster data
index_data{1, size(block_data, 2) - 7} = {};

%get data for each cluster
for idx = 8:size(block_data, 2) %starts at idx of block_data table that stores cluster data
    m = block_data{block_idx, idx}; %get data
    index_data{1, idx - 7} = m; %store data
     
    k = zeros(1, intra_block_size); %make array to graph
    k(m) = 1; %set each index in the cluster data to 1
    
    index_data{2, idx - 7} = k; %store graphable matrix in index_data table
end

%display intra and extracellularly recorded block data
intra_data = subplot(2, 1, 1); %create subplot for intracellular data

%% Change cluster displayed by changing index_data cell accessed
plot_plot = cell2mat(index_data(2, cluster_num)); %get matrix to plot
plot(plot_plot); %plot matrix

extra_data = subplot(2, 1, 2); %create subplot for extracellular data
extra_plot = block_data{block_idx, 4}; %get data to plot
plot(extra_plot); %plot data

% ALSO CHANGE MARKERS TO ACCESS APPROPRIATE CLUSTER DATA
markers = block_data{block_idx, cluster_num + 7}; %get indices of cluster spikes (cluster 1 = 8, cluster 2 = 9, etc)
marker_y = extra_plot(markers); %get y-values of extracellular trace for each index in markers

hold on; %don't erase current plot
plot(markers, marker_y, 'o'); %overlay markers representing cluster spikes

%label plots
ylabel(intra_data, 'Cluster Data'); %labeling y-axis with name of data helps preserve vertical space
ylabel(extra_data, 'Extracellular Data');


