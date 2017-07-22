%% Calculate Target Size In Pixels
% Author: Nicholas Garcia
% Version: 2017-07-19
% 
% This program finds the required size in pixels for a target of a specified size in degrees, 
% given the size and distance of a screen from the head of a dragonfly.
% Program prints result to console (sample output at bottom of page).

%% User configurable variables
% There are four variables that need to be configured: the width of the
% screen in centimeters and in pixels, the distance from the screen to the
% animal's head, and the desired target size in degrees.

    %screen width in pixels
    screen_width_px = 800;

    %screen width in cm
    screen_width_cm = 25;

    %screen distance in cm
    screen_distance_cm = 16;

    %desired target size in deg
    target_deg = 3.6;
    
    
%% Script

    %convert target size to rads for matlab
    target_rads = deg2rad(target_deg);
    
    %calculate target size in pixels
    target_size_px = tan(target_rads/2) * (screen_distance_cm/screen_width_cm) * screen_width_px * 2;
    
    %message to print with results
    message = ['Required size in pixels for target of ' num2str(target_deg) ' degrees: '];
    
    %display message with results
    disp([message num2str(target_size_px)]);

