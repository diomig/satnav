function [data] = filter_data(storage)

    data = storage;
%% Filter unwanted messages
    % Filter GGA sentences according to the QUALITY INDICATOR
    bad_quality = [0 6 7 8];
    good_gga = (~ismember(data.gga.quality, bad_quality));
    fn = fieldnames(data.gga);
    for k=1:numel(fn)
        data.gga.(fn{k}) = data.gga.(fn{k})(good_gga);
    end

    good_mode = ["A" "D"];
    
    % Filter GLL sentences according to the MODE INDICATOR
    good_gll = (ismember(data.gll.mode, good_mode));
    fn = fieldnames(data.gll);
    for k=1:numel(fn)
        data.gll.(fn{k}) = data.gll.(fn{k})(good_gll);
    end

    % Filter RMC sentences according to the MODE INDICATOR
    good_rmc = (ismember(data.rmc.mode, good_mode));
    fn = fieldnames(data.rmc);
    for k=1:numel(fn)
        data.rmc.(fn{k}) = data.rmc.(fn{k})(good_rmc);
    end
    
    % Filter VTG sentences according to the MODE INDICATOR
    good_vtg = (ismember(data.vtg.mode, good_mode));
    fn = fieldnames(data.vtg);
    for k=1:numel(fn)
        data.vtg.(fn{k}) = data.vtg.(fn{k})(good_vtg);
    end
    
    
%% Convert Coordinates    
    
    coord2rad = @(c) deg2rad(floor(c/100) + mod(c, 100)/60);
    
 %GGA
    data.gga.latitude = coord2rad(data.gga.latitude).*(2*(data.gga.NS=='N')-1);
    data.gga.longitude= coord2rad(data.gga.longitude).*(2*(data.gga.WE=='E')-1);
    data.gga = rmfield(data.gga,["NS" "WE" "alt_units" "gh_units"]);
 %GLL   
    data.gll.latitude = coord2rad(data.gll.latitude).*(2*(data.gll.NS=='N')-1);
    data.gll.longitude= coord2rad(data.gll.longitude).*(2*(data.gll.WE=='E')-1);
    data.gll = rmfield(data.gll,["NS" "WE"]);
 %RMC   
    data.rmc.latitude = coord2rad(data.rmc.latitude).*(2*(data.rmc.NS=='N')-1);
    data.rmc.longitude= coord2rad(data.rmc.longitude).*(2*(data.rmc.WE=='E')-1);
    data.rmc = rmfield(data.rmc,["NS" "WE"]);
end