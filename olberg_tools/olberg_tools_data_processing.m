%make sure prefs are set
init_prefs = exist('init', 'var');

%if prefs aren't set, run run prefs
if init_prefs ~= 7
    disp('Initializing prefs...')
    olberg_tools_prefs
    disp(['Done initializing prefs' newline])
end

%%%script
    %define start point
    last_block = 1;
    
    for idx = 1:num_blocks
        %get block data and transpose it from 1xn to nx1
        extra_block = input_file_obj.(char(extra_blocks(idx)))';
        intra_block = input_file_obj.(char(intra_blocks(idx)))';
        
        %invert because combinato reads positive spikes by default
        extra_block = -extra_block;
        intra_block = -intra_block;
        
        %store block name, start/end indices, and block data
        block_data{idx + 1, 1} = extra_blocks(idx);
        block_data{idx + 1, 2} = last_block;
        block_data{idx + 1, 3} = last_block + numel(extra_block) - 1;
        block_data{idx + 1, 4} = extra_block;
        
        block_data{idx + 1, 5} = intra_blocks(idx);
        block_data{idx + 1, 6} = intra_block;
        
        %increment block start index
        last_block = last_block + numel(extra_block);
    end

    %append block to data matrix (merges all blocks into single vector)
    data = horzcat(block_data{2:num_blocks, 4});    
