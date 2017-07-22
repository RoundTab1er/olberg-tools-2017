%% Process Wave_clus Output
% Author: Nicholas Garcia
% Version: 2017-07-19
%
% This script relies on a 2xn cell array named 'clusters'
% ('convert_clusters.m' generates and stores said array)

%% User Configurable Variables
% There is one configureable variable: the name of the file with clusters to be processed

    %file to load
    file_name = '2017-07-06-c-trimmed_processed';
    

%% Script

    %load file
    load([file_name '.mat']);

    %get number of clusters
    num_clusters = size(clusters, 2);
    
    %label clusters
    for idx = 1:num_clusters
        block_data{1, idx + 7} = ['cluster_' num2str(idx)];
    end

    %get number of blocks
    num_blocks = size(block_data, 1);
    
    %ms data array
    ms_data{num_blocks, num_clusters} = {};

    %sort clusters
    for col = 1:num_clusters
        for row = 1:num_blocks - 1
            %get block 
            block = clusters{2, col};

            %get block start and stop indices
            block_start = block_data{row + 1, 2}/40;
            block_end = block_data{row + 1, 3}/40;

            %get all indices between start and stop indices 
            cluster_in_block = find(block <= block_end & block >= block_start);

            %get values at indices
            b = block(cluster_in_block, 1);
            
            %save ms values
            ms_data{row, col} = b;
            
            %convert ms to indices
            b = b * 40;
            b = b - (block_data{row + 1, 2});
            
            %fix rounding errors (ie. convert back to integers)
            b = round(b, 0);

            %save to array
            block_data{row + 1, col + 7} = b;
        end
    end
    
    %save file (don't overwrite original file)
    save([file_name '.mat'], 'block_data', 'ms_data', '-append');
