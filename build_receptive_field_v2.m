%%%%%% Build receptive field   %%%%%%
%%%%%% Author: Nicholas Garcia %%%%%%
%%%%%% Version: 2017-07-07     %%%%%%


%%%% USER VARIABLES %%%%

    %%% BLOCK TO PROCESS %%%
    block = 'B17';
    
    %column that contains processed indices
    idx_col = 7; %7 --> intra data, 7 + cluster number --> cluster <num> data
    
    %%% STIMULUS %%%
    stim_id = '2'; % STIM FILE SHOULD HAVE ONE FIELD CALLED "Coords"
    
    %%% CONNECTIVE %%%
    side = 1; %1 for left, 2 for right (reverse for screen behind animal)
    
    %%% SAMPLING FREQUENCY %%%
    sampling_rate = 40000;
    
    %%% SPIKE LATENCY %%%
    spike_latency = 0.03; %30ms typical 
    
    %%% STARTTIME %%%
    start_time = 0.05; %time in s from beginning when stimulus started

%%%% END USER VARS %%%%
    

%%%% START SCRIPT %%%%

    %block to process
    block_id = [intra_channel_id block];
    
    %stim name
    stim_name = ['Stim' '_' stim_id '.mat'];
    
    %load processed indices
    %clear block_data;
    load([file_name '_processed.mat'], 'block_data')
    
    %calculate row that contains target block data
    array_size = length(block_data);
    temp_array{array_size, 1} = {};

    for idx = 1:array_size
        temp_array{idx, 1} = char(block_data{idx, 5});
    end

    %row that contains target block data
    block_idx = find(ismember(temp_array, block_id));
    
    %load indices for target block
    spike_indices = block_data{block_idx, idx_col}';
    
    %calculate spike times from indices
    spike_times = (spike_indices/sampling_rate) - start_time - spike_latency;
    
    %get coords
    load(stim_name, 'Coords'); %eval(stim_name);
    
    %reject spikes due to starting the stim (first 30ms or first frame)
    spike_times = spike_times(spike_times > 1/120);
    spike_times = spike_times(spike_times < (length(Coords) * 1/360)); 
    
    %flip y axis (animal mounted upside down)
    Coords(:, 3)= 600 - Coords(:, 3);
    
    % (Don't flip x-axis because of rear projection)
    location_ind = dsearchn(Coords(:, 1), spike_times);
    
    %find the nearest location corresponding to the each spike time
    spike_coord = Coords(location_ind, :); 

    before_spike_coord = Coords(location_ind - 1, :);
    after_spike_coord = Coords(location_ind + 1, :);
    
    %Interpolate x and y values
    time_diffs = spike_times - spike_coord(:, 1);
    correction_fraction = time_diffs/Coords(1, 1); %RasterArray(1,1) is the interval between fields

    %to make formulas smaller: rename variables used for interpolation
    len = length(correction_fraction);
    cf = correction_fraction;

    scb = before_spike_coord;
    sca = after_spike_coord;
    
    %interpolated spike coordinates
    sci = spike_coord;
    
    %interpolate the coordinates
    for i = 1:len
        if cf(i) >= 0
            sci(i, 2:3)= sci(i, 2:3) + cf(i) * (sca(i, 2:3) - sci(i, 2:3));
        else
            sci(i, 2:3) = sci(i, 2:3) - cf(i) * (sci(i, 2:3) - scb(i, 2:3));
        end
    end
    
    %move is xy movement before the spike
    move = [sci(:, 1) sci(:, 2:3) - scb(:, 2:3)];
    
    %divide the movement into rightleft (as we see on screen) or updown
    rt_ind = find(and(abs(move(:, 2)) > abs(move(:, 3)), move(:, 2) > 0));
    lt_ind = find(and(abs(move(: ,2)) > abs(move(:, 3)), move(:, 2) < 0));

    dn_ind = find(and(abs(move(:, 2)) < abs(move(:, 3)), move(:, 3) < 0));
    up_ind = find(and(abs(move(:, 2)) < abs(move(:, 3)), move(:, 3) > 0));
    
    %interpolated rightleft/updown coords
    lt_coords = sci(lt_ind, :);
    rt_coords = sci(rt_ind, :);
    up_coords = sci(up_ind, :);
    dn_coords = sci(dn_ind, :);

    %%% GENERATE FIGURE %%%
    
    %figure
    h = figure;

    
    scatter(rt_coords(:, 2),rt_coords(:, 3), 50, '>', 'r')
    hold on
    
    scatter(lt_coords(:,2),lt_coords(:, 3), 50, '<', 'MarkerEdgeColor', [0 .6 0])
    axis equal
    xlim([0 800])
    ylim([0 600])
    hold on
    
    scatter(up_coords(:, 2), up_coords(:, 3), 50, '^', 'MarkerEdgeColor', [.5 0 1])
    hold on
    
    scatter(dn_coords(: ,2), dn_coords(:, 3), 50, 'v', 'b')
    box on
    
    %label x axis with dragonfly view
    if side == 1
        xlabel('Ipsilateral                                                                                                      Contralateral')
    elseif side==2
        xlabel('Contralateral                                                                                                     Ipsilateral')
    end
    
    r_spikes = length(rt_coords(:, 1));
    l_spikes = length(lt_coords(:, 1));
    u_spikes = length(up_coords(:, 1));
    d_spikes = length(dn_coords(:, 1));

    spike_numbers_rtlt_updn = [r_spikes l_spikes u_spikes d_spikes];
    
    %figure title
    new_name = strrep(stim_name, '_', '-');
    title([file_name ' Block' block ', ' new_name '  [' num2str(r_spikes) ', ' num2str(l_spikes) ', ' num2str(u_spikes) ', ' num2str(d_spikes) ' ]' '  (R, L, U, D)' ])

    %save figure as .eps, .fig, and .pdf
    saveas(h, [file_name 'Block' block 'Stim' stim_id], 'eps');
    saveas(h, [file_name 'Block' block 'Stim' stim_id], 'fig');
    saveas(h, [file_name 'Block' block 'Stim' stim_id], 'pdf');
    
    