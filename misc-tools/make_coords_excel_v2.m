%% Convert Excel File To .mat Coord File 
% Author: Nicholas Garcia
% Version: 2017-07-19
%
% This script is for converting exel files only. There is a different
% script for converting stim-gl docs

%% User Configureable Variables
% There is one user configureable variable: the name of the stim file.

    %stim name
    stim_id = '2-40A';
    
%% Script

    %stim file to load
    file_name = [stim_id '.xlsx'];

    %read excel file into double array of coords
    Coords = xlsread(file_name);

    %save file
    save(['Stim_' stim_id], 'Coords');