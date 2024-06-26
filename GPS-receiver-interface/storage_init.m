function [storage, index] = storage_init(summary)
% Initialise the storage structure
% it uses memory preallocation for speed purposes
    [gga_s, gll_s, gsa_s, gsv_s, rmc_s, vtg_s, zda_s] = msg_formats(summary);
    storage = struct(   'gga', gga_s,...
                        'gll', gll_s,...
                        'gsa', gsa_s,...
                        'gsv', gsv_s,...
                        'rmc', rmc_s,...
                        'vtg', vtg_s,...
                        'zda', zda_s);

    index = struct('gga',1, 'gll',1, 'gsa',1, 'gsv',1, 'rmc',1, 'vtg',1, 'zda',1);
  
end