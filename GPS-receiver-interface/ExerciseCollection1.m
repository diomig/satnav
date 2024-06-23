%% Parse the whole file (migth take a while)
%    - DON'T FORGET TO SAVE WORKSPACE AFTER RUNNING THIS SEGMENT
clear, clc
global filename;
filename = 'ISTShuttle.nmea';
 
[storage, N, summary] = decode_file(filename);

nmea = filter_data(storage);

%% Exercise 1 – NMEA Sentence Counter
clc
%[N, summary] = inspect(filename);
% Number of messages:
% Ctrl+F('$') --> 62966
fprintf('\nNumber of messages: %d\n', N);
% Number of GGA messages:
% Ctrl+F('$GPGGA') --> 9287
%Number of GLL messages:
% Ctrl+F('$GPGLL') --> 9287
fprintf('SUMMARY:\n')
disp([summary{1},summary{2}])



%% Exercise 2 – NMEA Sentences
fprintf('\n\nNMEA Sentences:\n')
disp(summary{1})

%% Exercise 3 – Message Rate

%for each msg_type:
%   AvgMsgPeriod = (UTC_lastMsg - UTC_firstMsg) / N_msg
%     'GPGGA'   ->  (11:33:58.600 - 11:02:59.400)/9287 = 0.2 s
%     'GPGLL'   ->  (11:33:58.600 - 11:02:59.600)/9287 = 0.2 s
%     'GPGSA'   ->  Does not have UTC
%     'GPGSV'   ->  Does not have UTC
%     'GPRMC'   ->  (11:33:58.600 - 11:02:59.400)/9287 = 0.2 s
%     'GPVTG'   ->  Does not have UTC
%     'GPZDA'   ->  (11:33:58.400 - 11:02:59.400)/9287 = 0.2 s

%   AvgMsgPeriod = 0.2s
% (as the messages are sent sequentially, we can assume the AvgMsgPeriod
%  is about the same for the remaining messages)

%   AvgMsgRate = 1 / AvgMsgPeriod = 5 Hz


%% Exercise 4 – Date and Time
day = nmea.zda.day(1); month = nmea.zda.month(1); year = nmea.zda.year(1);
utc = nmea.zda.utc(1);
str = sprintf('%02d/%02d/%4d  %s', day, month, year, utc_format(utc));
disp(['BEGIN:   ' str]);

day = nmea.zda.day(end); month = nmea.zda.month(end); year = nmea.zda.year(end);
utc = nmea.zda.utc(end);
str = sprintf('%02d/%02d/%4d  %s', day, month, year, utc_format(utc));
disp(['END:     ' str]);

clear day month year utc str

%% Exercise 5 - Lat/Lon Box

latlonbox(nmea);

%% Exercise 6 – Highest and Lowest Points

plot_altitude(nmea);

%% Exercise 7 – Cumulative Elevation Gain

cumulative_elevation_gain(nmea);

%% Exercise 8 – Speed over Ground

plot_speed(nmea);

%% Exercise 9 – Satellites in View
siv = nmea.gsv.sats_in_view;
gsv_utc = map_utc(nmea.gsv, nmea.gga);
figure(8)
plot(gsv_utc, siv);
ylabel('Satellites in View');
xlabel('Message');
fprintf('\n\nMaximum number of satellites in view: %d\n\n\n', max(siv))
clear siv


%% Exercise 10 – Satellites Elevation

[max_el, i] = max(nmea.gsv.sat_el);
sat = nmea.gsv.sat_ID(i);

fprintf('\n\nSatellite with the highest elevation has the ID: %d\n', sat);
fprintf('Elevation is %3.1fº\n\n', max_el);



%% Exercise 11 – NMEA Checksum

inspect('ISTShuttle.nmea');


%% Exercise 11 – EXTRA EXERCISE

inspect('slice.csv');

