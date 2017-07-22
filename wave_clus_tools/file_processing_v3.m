%% Script To Process LabChart Matlab Output
% Author: Nicholas Garcia
% Version: 2017-07-19
%
% The Matlab file output by Labchart should contain the AC-coupled
% intracellular and extracellular channels, with only the blocks that are
% to be analyzed. Script expects the blocks to be named in the format
% 'CxBy'(as of version date this is the default behavior). File needss to
% be in Matlab path.

%% User Configureable Variables
% There are four configurable variables: the name of the file to load, the
% channel id's for the intra and extra-cellular channels, and the threshold
% to be used for the intracellular processing

    %file to load
    file_name = '2017-07-06-c-trimmed';

    %intracellular channel to process
    intra_channel_id = 'C2'; %IF NO INTRACELLULAR USE SAME VALUE AS EXTRA_CHANNEL_ID

    %extracellular channel to process
    extra_channel_id = 'C2';

    %intracellular processing threshold value
    threshold = 0.3; %in milivolts

    
%% Load File
% Currently this is inefficient, as it loads the data twice, but it both
% needs to be in the workspace, and accessible by the file.(variable) lines
%in both of the processing scripts
    %load file
    load([file_name '.mat']);
    file = load([file_name '.mat']);
    
    
%% Script
% Simply runs the intra and extra-cellular processing scripts and saves the
% output. 
    
    %convert block data into vector waveclus can read
    file_converter_v6

    %get intracellular spikes
    intracellular_processing_v7
    
    %% Save As .mat File
    % One 1xn double matrix called 'data' is saved containing all of the
    % extracellular channel blocks for wave_clus analysis, as well as a cell array
    % containing each individual block's data on separate rows. The columns
    % are as follows: extracellular block name, block start, block end (in indices),
    % intracellular block name, block data, block peak indices, then
    % cluster peak indices
    save([file_name '_processed'], 'data', 'block_data');
