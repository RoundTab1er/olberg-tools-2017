%input_file = '2017-07-06-c-trimmed';

%make sure prefs are set
init_prefs = exist('init', 'var');

%if prefs aren't set, run run prefs
if init_prefs ~= 7
    disp('Initializing prefs...')
    olberg_tools_prefs
    disp(['Done initializing prefs' newline])
end

cd([userpath '\data\' input_file_name '\processed_data'])

%input_file_name = '2017-07-06-c-trimmed_processed';

%cluster_file = '2017-07-06-c-trimmed_processed.mat';

cluster_file_obj = matfile([input_file_name '_processed.mat']);

cluster_class = cluster_file_obj.cluster_class;
spike_times = cluster_file_obj.spike_times;

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
    clusters{2, idx} = spike_times(cluster_indices);
end

save([input_file_name '_processed.mat'], 'clusters', '-append');
