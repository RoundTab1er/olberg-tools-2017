%%%%%% Get spike times from file %%%%%%
%%%%%% Author: Nicholas Garcia   %%%%%%
%%%%%% Version: 2017-07-08       %%%%%%

%% Process Intracellular Data For Spike Finding By Thresholding
% Author: Nicholas Garcia
% Version: 2017-07-19
%
% 

%% User Configureable Variables
% These variables are set in the 'file_processing.m' script.    


%% Script

    %get all blocks in channel containing the given channel id (saves to 
    %cell array where each cell contains a character vector)
    C = who([intra_channel_id '*']);

    %get num blocks
    size = numel(C);

    for idx = 1:size
        %get block data and transpose it from 1xn to nx1
        block = file.(char(C(idx)))';

        %get spikes above min threshold
        block(block < threshold) = 0;

        %get indices of spikes
        [peaks, indices] = findpeaks(block);
 
        %store block name, start/end indices, data, and spike indices
        block_data{idx + 1, 5} = C(idx);
        block_data{idx + 1, 6} = block;
        block_data{idx + 1, 7} = indices;
        
    end
