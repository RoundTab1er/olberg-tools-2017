%% Convert Stim_gl Coord Output to .mat File
% Author: Nicholas Garica 
% Version: 2017-07-19
%
% This script is for converting stim-gl files only. There is a different
% script for converting exel docs


%% User configurable variables
% There are two user configurable variables: the name of the stimulus, and
% the name of the stim-gl coord file to read from. The stim-gl file needs
% to be in the matlab path.

    %name of stim program (file name is based on this)
    stim_id = '2-40';

    %stim-gl output file to read
    file_name = 'MovingObjects_20060107_4';

%% Start Script

    %file name to save coord file as
    coord_file_name = ['Stim_' stim_id];

    %load stim-gl coord file
    file = importdata([file_name '.txt']);

    %get data matrix from structure
    data = file.data;

    %get size of data matrix
    array_size = size(data, 1);

    %initiliaze array
    Coords = zeros(array_size, 3);

    %copy data over to coord array (columns 5 and 6 are x and y coords,
    %repspectively). Times are saved to first column, by dividing the frame
    %by the number of frames per second
    for idx = 1:array_size
        Coords(idx, 1) = idx/360;
        Coords(idx, 2) = data(idx, 5);
        Coords(idx, 3) = data(idx, 6);
    end

    %save .mat file
    save(coord_file_name, 'Coords');

