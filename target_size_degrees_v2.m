%% Calculate Target Size In Degrees
% Author: Nicholas Garcia
% Version: 2017-07-19
% 
% This program finds the size in degrees of a target, given the size of the target in
% pixels and the size and distance of a screen from the head of a
% dragonfly. Program prints message to console with result (sample output
% at bottom of page).


%% User configurable variables
% There are four variables that need to be configured: the width of the
% screen in centimeters and in pixels, the distance from the screen to the
% animal's head, and the target size in pixels.

    %screen width in pixels
    screen_width_px = 800;

    %screen width in cm
    screen_width_cm = 25;

    %screen distance in cm
    screen_distance_cm = 16;

    %desired target size in deg
    target_width_px = 177;    
    
    
%% Script

    %calculate target size in radians
    target_size_rads = atan(((target_width_px/2)/(screen_width_px)) * (screen_width_cm)/screen_distance_cm) * 2;

    %convert rads to degs
    target_size_degrees = rad2deg(target_size_rads);
    
    %message to display with results
    message = ['Size in degrees for target of ' num2str(target_width_px) ' pixels: '];
    
    %display message with results
    disp([message num2str(target_size_degrees)]);
