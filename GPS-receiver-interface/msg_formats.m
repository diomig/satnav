function [gga_s, gll_s, gsa_s, gsv_s, rmc_s, vtg_s, zda_s] = msg_formats(summary)

    tag = summary{1}; count = summary{2};

    
    
%% -----------------------------------------------------------        
%GPGGA
    type = "$GPGGA"; len = count(tag==type);
    %gga_s.type = strings(len, 1);
    gga_s.utc = zeros(len, 1);
    gga_s.latitude = zeros(len, 1);
    gga_s.NS =strings(len, 1);
    gga_s.longitude = zeros(len, 1);
    gga_s.WE =strings(len, 1);
    gga_s.quality = zeros(len, 1);
    gga_s.nsats = zeros(len, 1);
    gga_s.hdop = zeros(len, 1);
    gga_s.altitude = zeros(len, 1);
    gga_s.alt_units =strings(len, 1);
    gga_s.geoid_height = zeros(len, 1);
    gga_s.gh_units =strings(len, 1);
    gga_s.age = zeros(len, 1);
    gga_s.dgps =strings(len, 1);
    gga_s.num = zeros(len, 1);        
            
%% -----------------------------------------------------------
% GPGLL 
    type = "$GPGLL"; len = count(tag==type);   
    %gll_s.type =strings(len, 1);
    gll_s.latitude = zeros(len, 1);
    gll_s.NS =strings(len, 1);
    gll_s.longitude = zeros(len, 1);
    gll_s.WE =strings(len, 1);
    gll_s.utc = zeros(len, 1);
    gll_s.status =strings(len, 1);
    gll_s.mode =strings(len, 1);
    gll_s.num = zeros(len, 1);

%% -----------------------------------------------------------
% GPGSA
    type = "$GPGSA"; len = count(tag==type);
    %gsa_s.type =strings(len, 1);
    gsa_s.mode =strings(len, 2);
    gsa_s.satIDs =strings(len, 12);
    gsa_s.pdop =zeros(len, 1);
    gsa_s.hdop =zeros(len, 1);
    gsa_s.vdop =zeros(len, 1);
    gsa_s.num = zeros(len, 1);
%% -----------------------------------------------------------
% GPGSV
    type = "$GPGSV"; len = count(tag==type);
    %gsv_s.type =strings(len, 1);
    gsv_s.total =zeros(len, 1);
    gsv_s.msg_num =zeros(len, 1);
    gsv_s.sats_in_view =zeros(len, 1);
    gsv_s.sat_ID =zeros(len, 1);
    gsv_s.sat_el =zeros(len, 1);
    gsv_s.sat_az =zeros(len, 1);
    gsv_s.snr =zeros(len, 1);
    gsv_s.data =strings(len, 12);
    gsv_s.num = zeros(len, 1);
%% -----------------------------------------------------------
% GPRMC
    type = "$GPRMC"; len = count(tag==type);
    %rmc_s.type = strings(len, 1);
    rmc_s.utc = zeros(len, 1);
    rmc_s.status =strings(len, 1);
    rmc_s.latitude = zeros(len, 1);
    rmc_s.NS =strings(len, 1);
    rmc_s.longitude = zeros(len, 1);
    rmc_s.WE =strings(len, 1);
    rmc_s.speedN = zeros(len, 1);
    rmc_s.tcog = zeros(len, 1);
    rmc_s.date = zeros(len, 1);
    rmc_s.magvar =strings(len, 2);
    rmc_s.mode =strings(len, 1);
    rmc_s.num = zeros(len, 1);


%% -----------------------------------------------------------
% GPVTG
    type = "$GPVTG"; len = count(tag==type);
    %vtg_s.type =strings(len, 1);
    vtg_s.tcog = zeros(len, 1);
    vtg_s.magvar =strings(len, 1);
    vtg_s.speedN = zeros(len, 1);
    vtg_s.speedK = zeros(len, 1);
    vtg_s.mode =strings(len, 1);
    vtg_s.num = zeros(len, 1);

%% -----------------------------------------------------------
% GPZDA
    type = "$GPZDA"; len = count(tag==type);
    %zda_s.type =strings(len, 1);
    zda_s.utc = zeros(len, 1);
    zda_s.day = zeros(len, 1);
    zda_s.month = zeros(len, 1);
    zda_s.year = zeros(len, 1);
    zda_s.num = zeros(len, 1);
end