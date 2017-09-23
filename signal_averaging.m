nb = 75 % Enter the number of blocks to average;

% figure 1 = full figure (1sec) with and without stimulus (stimulus =
% 250msec - 750-msec)

frequency = '500Hz';

blockarray = zeros([40000,nb]);

for blocknum = 1:nb;

  blockname =  ['C1B' num2str(blocknum)] ;
  
  data = eval(blockname);
    
blockarray(:,blocknum) = data;

end;

averagetrace=sum(blockarray')/nb;

times = [1:40000]/40000;

full_fig = figure('Name','full stim')
plot(times,averagetrace)

ylim([-.2 .2]);
 title('09-20-17 500hz')
 ylabel('output')
 xlabel('time')

%  figure 2 = no stim 500msec of before and after plugged together: first
%  250msec and last 250msec no stimulus data

no_stim_fig = figure('Name','no stim')
no_stim_trace = averagetrace([1:10000 30001:40000]);
no_stim_times = times(1:20000);


plot(no_stim_times,no_stim_trace)
ylim([-.2 .2]);

% figure 3 = just 500msec of stim (250msec - 750msec)

stim_fig = figure('Name','stim')
stim_trace = averagetrace(10001:30000);
stim_times = times(10001:30000);


plot(stim_times,stim_trace)
ylim([-.2 .2]);

