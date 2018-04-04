%set prefs
disp('Initializing prefs...')
olberg_tools_prefs
disp(['Done initializing prefs' newline])

%%call scripts 
%set up file structure
disp('Setting up folders...')
olberg_tools_organization

%run init
disp(['Initializing file...' newline])
olberg_tools_init

%process data
disp('Processing data...')
disp(['Processing extracellular trace on channel ' extra_channel_id '...'])
disp(['Processing intracellular trace on channel ' intra_channel_id '...' newline])
olberg_tools_data_processing

%save data
disp(['Saving data to ' userpath '\data\' input_file_name '\data' '...' newline])
%olberg_tools_save_data

%remove unecessary vars
clear('idx', 'has_folder', 'msg', 'msgID', 'status')

disp(['Processing complete' newline])
