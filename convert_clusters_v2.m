%% Get Clusters From Wave_clus Output 
% Author: Nicholas Garcia
% Version: 2017-07-21

%% User Configurable Variables
% There is one configurable variable: the wave_clus output file to be loaded

    %file to load
    file_name = 'times_2017-07-06-c-trimmed_processed.mat';
    
    %file to save to
    save_file = '2017-07-06-c-trimmed_processed.mat';
    
%% Script

    %load cluster file
    load(file_name, 'cluster_class');

    %get number of clusters 
    num_clusters = max(cluster_class); %max value is highest numbered cluster, which is the number of clusters
    num_clusters = num_clusters(1, 1); %previous line returns 2 value matrix, get the first value (first dimension)
    
    %cluster holder 
    clusters{2, num_clusters} = {};

    %label clusters
    for idx = 1:num_clusters
        clusters{1, idx} = ['cluster_' num2str(idx)];
    end

    %get clusters
    for idx = 1:num_clusters
        %get indices of rows that contain 
        cluster_indices = find(cluster_class == idx); %find cells in first column that are equal to current cluster

        %get values at indices (get values from second col for each row we
        %found before
        clusters{2, idx} = cluster_class(cluster_indices, 2);
    end
    
    %save file (add it to file created from the 'file_processing' script
    save(save_file, 'clusters', '-append');
   
    
    
    