%% Plot Results From Wave_clus
% Author: Nicholas Garcia
% Version: 2017-07-19

%% User Configurable Variables
% There is one configurable variable: the block id ('B' plus the number
% of the block) to be processed.

    %channel to graph
    channel_id = 'C2';

    %block to graph
    block = 'B17';
    
    %cluster to graph (1, 2, 3, etc)
    cluster_num = 1;
    
    %file to graph
    file_name = '2017-07-06-c-trimmed_processed';
    
    %%%STUFF
    intra_col = 6;
    extra_col = 4;

%% Script
    %load file
    load(file_name);

    %block to process
    block_id = [channel_id block];
    
    %create arrays
    array_size = size(cluster_data, 1) - 1;
    temp_array{array_size, 1} = {};

    %convert to char vector and copy over
    for idx = 1:array_size
        temp_array{idx, 1} = char(cluster_data{idx + 1, 1});
    end

    %find row that contains target block data
    block_idx = find(ismember(temp_array, block_id));

    intra_data_to_plot = block_data{block_idx, intra_col};
    extra_data_to_plot = block_data{block_idx, extra_col};
    cluster_to_plot = cluster_data{block_idx, cluster_num + 1};
    
    cluster_spikes = extra_data_to_plot(cluster_to_plot);
    cluster_info = intra_data_to_plot(cluster_to_plot);
    
%create figure    
results = figure;

%% Change cluster displayed by changing index_data cell accessed
plot(-intra_data_to_plot + 1);
hold on
plot(-extra_data_to_plot);

hold on; %don't erase current plot
plot(cluster_to_plot, cluster_spikes, 'o', 'MarkerEdgeColor', 'blue'); %overlay markers representing cluster spikes

hold on; %don't erase current plot
plot(cluster_to_plot, cluster_info + 1, 'o', 'MarkerEdgeColor', 'red'); %overlay markers representing cluster spikes

%label plots
%ylabel(results, 'Cluster Data'); %labeling y-axis with name of data helps preserve vertical space
%ylabel(extra_data, 'Extracellular Data');


