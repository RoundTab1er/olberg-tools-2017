%%% SET UP FILE STRUCTURE
home_dir = userpath;

%set current folder to top level folder
cd(home_dir)

%check for data folder
has_folder = exist('data', 'dir');

if has_folder ~= 7
    [status] = mkdir('data');
    
    if status ~= 1
        error('data folder could not be created')
    end
end

%make folder for data file
[status] = mkdir(['data/' input_file_name]);

if status ~= 1
    error('session folder could not be created')
end

%create subfolders
cd(['data/' input_file_name])
[status] = mkdir('processed_data');

if status ~= 1
    error('processed data folder could not be created')
end

[status] = mkdir('raw_cluster_data');

if status ~= 1
    error('raw cluster data folder could not be created')
end

[status] = copyfile([home_dir '\' input_file_name '.mat']);

if status ~= 1
    error('Could not move file');
end