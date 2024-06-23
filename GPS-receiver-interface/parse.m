function [data] = parse(sentence)
% parse the string of characters into a data structure

    switch (sentence(1))
%% -----------------------------------------------------------        
%GPGGA
        case "$GPGGA" 
            gpgga.type = sentence(1);
            gpgga.utc = str2double(sentence(2));
            gpgga.latitude = str2double(sentence(3));
            gpgga.NS = sentence(4);
            gpgga.longitude = str2double(sentence(5));
            gpgga.WE = sentence(6);
            gpgga.quality = str2double(sentence(7));
            gpgga.nsats = str2double(sentence(8));
            gpgga.hdop = str2double(sentence(9));
            gpgga.altitude = str2double(sentence(10));
            gpgga.alt_units = sentence(11);
            gpgga.geoid_height = str2double(sentence(12));
            gpgga.gh_units = sentence(13);
            gpgga.age = str2double(sentence(14));
            gpgga.dgps = sentence(15);
            data = gpgga;  
            
% GPS quality indicator: 
% 0 – Fix not available or invalid
% 1 – GPS SPS Mode, fix valid
% 2 – Differential GPS, SPS Mode, fix valid
% 3 – GPS PPS Mode, fix valid
% 4 – System used in RTK mode, with fixed integers
% 5 – System used in Float RTK, with floating integers
% 6 – Estimated (dead reckoning) mode
% 7 – Manual input mode
% 8 – Simulator mode


%% -----------------------------------------------------------
% GPGLL 
        case "$GPGLL" 
            gpgll.type = sentence(1);
            gpgll.latitude = str2double(sentence(2));
            gpgll.NS = sentence(3);
            gpgll.longitude = str2double(sentence(4));
            gpgll.WE = sentence(5);
            gpgll.utc = str2double(sentence(6));
            gpgll.status = sentence(7);
            gpgll.mode = sentence(8);
            data = gpgll;
% Mode indicator: 
% A – Autonomous mode
% D – Differential mode
% E – Estimated (dead reckoning) mode
% M – Manual input mode
% S – Simulator mode
% N – Data not valid
% Status = V for all modes except A and D.

%% -----------------------------------------------------------
% GPGSA
        case "$GPGSA"
            gpgsa.type = sentence(1);
            gpgsa.mode = sentence(2:3);
            gpgsa.satIDs = sentence(4:15);
            gpgsa.pdop = str2double(sentence(16));
            gpgsa.hdop = str2double(sentence(17));
            gpgsa.vdop = str2double(sentence(18));
            data = gpgsa;
            
%% -----------------------------------------------------------
% GPGSV
        case "$GPGSV"
            gpgsv.type = sentence(1);
            gpgsv.total = str2double(sentence(2));
            gpgsv.msg_num = str2double(sentence(3));
            gpgsv.sats_in_view = str2double(sentence(4));
            gpgsv.sat_ID = str2double(sentence(5));
            gpgsv.sat_el = str2double(sentence(6));
            gpgsv.sat_az = str2double(sentence(7));
            gpgsv.snr = str2double(sentence(8));
            gpgsv.data = sentence(9:end-1);
            data = gpgsv;
        
%% -----------------------------------------------------------
% GPRMC
        case "$GPRMC"
            gprmc.type = sentence(1);
            gprmc.utc = str2double(sentence(2));
            gprmc.status = sentence(3);
            gprmc.latitude = str2double(sentence(4));
            gprmc.NS = sentence(5);
            gprmc.longitude = str2double(sentence(6));
            gprmc.WE = sentence(7);
            gprmc.speedN = str2double(sentence(8));
            gprmc.tcog = str2double(sentence(9));
            gprmc.date = str2double(sentence(10));
            gprmc.magvar = sentence(11:12);
            gprmc.mode = sentence(13);
            data = gprmc;
% Mode indicator: 
% A – Autonomous mode
% D – Differential mode
% E – Estimated (dead reckoning) mode
% M – Manual input mode
% S – Simulator mode
% N – Data not valid
% Status = V for all modes except A and D.

            
%% -----------------------------------------------------------
% GPVTG
        case "$GPVTG"
            gpvtg.type = sentence(1);
            gpvtg.tcog = str2double(sentence(2));
            gpvtg.magvar = sentence(4);
            gpvtg.speedN = str2double(sentence(6));
            gpvtg.speedK = str2double(sentence(8));
            gpvtg.mode = sentence(10);
            data = gpvtg;
            
% Mode indicator: 
% A – Autonomous mode
% D – Differential mode
% E – Estimated (dead reckoning) mode
% M – Manual input mode
% S – Simulator mode
% N – Data not valid

%% -----------------------------------------------------------
% GPZDA
        case "$GPZDA"
            gpzda.type = sentence(1);
            gpzda.utc = str2double(sentence(2));
            gpzda.day = str2double(sentence(3));
            gpzda.month = str2double(sentence(4));
            gpzda.year = str2double(sentence(5));
            data = gpzda; 
        
        
        otherwise
                data = [];
    end
    
    
end