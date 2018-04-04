%%% SET PREFS

% FILE LOADING
    %file to load, leave off .mat
    input_file_name = '2017-07-06-c-trimmed';
    
% PROGRAM PARAMETERS
    %sampling rate
    sr = 40000;
    
    %intracellular channel to process
    intra_channel_id = 'C4'; %IF NO INTRACELLULAR USE SAME VALUE AS EXTRA_CHANNEL_ID

    %extracellular channel to process
    extra_channel_id = 'C2';

    %intracellular processing threshold value
    threshold = 0.3; %in milivolts
    
init = true;