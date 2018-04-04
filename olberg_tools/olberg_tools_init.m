%%% PERFORM ALL REQUIRED INITIALIZATION 
%get imput file
input_file = [input_file_name '.mat'];

%initialize required file objects
input_file_obj = matfile(input_file);

%get list of vars that contain desired channel data
extra_blocks = who(input_file_obj, [extra_channel_id '*']);
intra_blocks = who(input_file_obj, [intra_channel_id '*']);

%get num blocks, can use either intra or extra
num_blocks = numel(extra_blocks);

%initialize data storage matrix
block_data{num_blocks + 1, 7} = {};

%label columns
block_data{1, 1} = 'block_id';
block_data{1, 2} = 'start_index';
block_data{1, 3} = 'end_index';
block_data{1, 4} = 'extra_data';
block_data{1, 5} = 'intra_block_id';
block_data{1, 6} = 'intra_data';
block_data{1, 7} = 'peak_indices';  