%retrieve info from .h5 output files from combinato
input_file_name = '2017-07-06-c-trimmed';
cd([userpath '\data\' input_file_name '\raw_cluster_data'])
cluster_files = ls('*.h5');

num_files = size(cluster_files, 1);

for file = 1:num_files
    filename = strtrim(cluster_files(file, :));
    
    info = h5info(filename);

    root = info.Name;
    datasets = info.Datasets;
    
    num_groups = size(datasets, 1);
    
    group_names{num_groups, 1} = {};
    
    for group = 1:num_groups
        group_names{group, 1} = datasets(group).Name;
    end

    disp(group_names)
    num_groups = numel(group_names);
    %data{2, num_groups} = {};
    
    for name = 1:num_groups
        group = group_names{name, 1};
        %data{1, name} = group;
        %data{2, name} = h5read(filename, [root group]);
        data.(group) = h5read(filename, [root group]);
    end    
    
    %disp(data)
    
    save([userpath '\data\' input_file_name '\processed_data\' filename '.mat'], 'data');
    clear('group_names', 'data', 'datasets');
    disp(['done with: ' filename])
end
    
    
    