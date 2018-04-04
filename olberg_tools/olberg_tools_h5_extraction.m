%make sure prefs are set
init_prefs = exist('init', 'var');

%if prefs aren't set, run run prefs
if init_prefs ~= 7
    disp('Initializing prefs...')
    olberg_tools_prefs
    disp(['Done initializing prefs' newline])
end

%retrieve info from .h5 output files from combinato
%input_file_name = '2017-07-06-c-trimmed';
cd([userpath '\data\' input_file_name '\raw_cluster_data'])
cluster_files = ls('*.h5');

num_files = size(cluster_files, 1);

for file = 1:num_files
    filename = strtrim(cluster_files(file, :));
    
    info = h5info(filename);

    root = info.Name;
    datasets = info.Datasets;
    groups = info.Groups;
    
    num_datasets = size(datasets, 1);
    num_groups = size(groups, 1);

    dataset_names{num_datasets, 1} = {};
        
    if num_groups > 0
        group_datasets{num_groups, 1} = {};
        
        for group = 1:num_groups
            group_name = groups(group).Name;
            
            data_test = groups(group).Datasets;      
            num_sets = size(data_test, 1);
            
            for set = 1:num_sets
                data_name = data_test(set).Name;
                data.(strip(group_name, '/')).(data_name) = h5read(filename, [root group_name '/' data_name]);
            end
        end
    end
    
    for group = 1:num_datasets
        dataset_names{group, 1} = datasets(group).Name;
    end
    
    num_datasets = numel(dataset_names);
    
    for name = 1:num_datasets
        dataset = dataset_names{name, 1};
        data.(dataset) = h5read(filename, [root dataset]);
    end 
    
    save([userpath '\data\' input_file_name '\processed_data\' filename '.mat'], 'data');
    clear('dataset_names', 'data');
    disp(['done with: ' filename])
end