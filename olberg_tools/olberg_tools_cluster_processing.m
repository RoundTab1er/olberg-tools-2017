%input_file_name = '2017-07-06-c-trimmed';

%make sure prefs are set
init_prefs = exist('init', 'var');

%if prefs aren't set, run run prefs
if init_prefs ~= 7
    disp('Initializing prefs...')
    olberg_tools_prefs
    disp(['Done initializing prefs' newline])
end

cd([userpath '\data\' input_file_name '\processed_data'])

spike_file = ls('data*');
cluster_file = ls('sort_*');

spike_file_obj = matfile(spike_file);
cluster_file_obj = matfile(cluster_file);

spike_file = spike_file_obj.data;
spike_times = spike_file.pos.times;

cluster_file = cluster_file_obj.data;
cluster_class = cluster_file.classes;
cluster_index = cluster_file.index;

olberg_tools_save_extracted_data