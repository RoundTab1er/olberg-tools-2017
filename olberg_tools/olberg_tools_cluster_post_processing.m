%file to load
%file_name = '2017-07-06-c-trimmed_processed';

%make sure prefs are set
init_prefs = exist('init', 'var');

%if prefs aren't set, run run prefs
if init_prefs ~= 7
    disp('Initializing prefs...')
    olberg_tools_prefs
    disp(['Done initializing prefs' newline])
end

cd([userpath '\data\' input_file_name '\processed_data'])

cluster_file_obj = matfile([input_file_name '_processed.mat']);
block_data = cluster_file_obj.block_data;
clusters = cluster_file_obj.clusters;
%ms_conversion_factor = cluster_file_obj.sr/1000; 
ms_conversion_factor = sr/1000; 

%get number of clusters
num_clusters = size(clusters, 2);

cluster_data{2, num_clusters} = {};

%label clusters
for idx = 1:num_clusters
    cluster_data{1, idx + 1} = ['cluster_' num2str(idx)];
end

%get number of blocks
num_blocks = size(block_data, 1);

%label blocks
for idx = 1:num_blocks
    cluster_data{idx, 1} = block_data{idx, 1};
end

%ms data array
ms_data{num_blocks, num_clusters} = {};

%sort clusters
for col = 1:num_clusters
    for row = 1:num_blocks - 1
        %get block 
        block = clusters{2, col};

        %get block start and stop indices
        block_start = block_data{row + 1, 2}/ms_conversion_factor;
        block_end = block_data{row + 1, 3}/ms_conversion_factor;

        %get all indices between start and stop indices (ie, get the indices for each block)
        cluster_in_block = find(block <= block_end & block >= block_start);

        %get values at indices
        b = block(cluster_in_block, 1);

        %save ms values
        %ms_data{row, col} = b;

        %convert ms to indices
        b = b * ms_conversion_factor;
        b = b - (block_data{row + 1, 2});

        %fix rounding errors (ie. convert back to integers)
        b = round(b, 0);

        %save to array
        cluster_data{row + 1, col + 1} = b;
    end
end

%save file (don't overwrite original file)
%save([input_file_name '.mat'], 'cluster_data', 'ms_data', '-append');
save([input_file_name '_processed.mat'], 'cluster_data', '-append');
