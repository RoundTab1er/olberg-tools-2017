%% Process Extracellular Data for Wave_clus Analysis
% Author: Nicholas Garcia
% Version: 2017-07-19
%
%

%% User Configureable Variables
% These variables are set in the 'file_processing.m' script.
    

%% Script

    %get all blocks in channel containing the given channel id (saves to 
    %cell array where each cell contains a character vector)
    C = who([extra_channel_id '*']);

    %get num blocks
    size = numel(C);
    
    %initialize storage matrices
    data = [];
    block_data{size + 1, 5} = {};
    
    %define start point
    last_block = 1;
    
    %label columns
    block_data{1, 1} = 'block_id';
    block_data{1, 2} = 'start_index';
    block_data{1, 3} = 'end_index';
    block_data{1, 4} = 'extra_data';
    block_data{1, 5} = 'intra_block_id';
    block_data{1, 6} = 'intra_data';
    block_data{1, 7} = 'peak_indices';    

    for idx = 1:size
        %get block data and transpose it from 1xn to nx1
        block = file.(char(C(idx)))';

        %append block to data matrix (merges all blocks into single vector
        data = horzcat(data, block);    
        
        %store block name, start/end indices, and block data
        block_data{idx + 1, 1} = C(idx);
        block_data{idx + 1, 2} = last_block;
        block_data{idx + 1, 3} = last_block + numel(block) - 1;
        block_data{idx + 1, 4} = block;
        
        %increment block start index
        last_block = last_block + numel(block);
    end
