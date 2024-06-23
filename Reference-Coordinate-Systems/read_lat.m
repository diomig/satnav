function coord_rad = read_lat(s)
%% Example: s = "38º46´49.61´´N";

if isstring(s) || ischar(s)
    c = char(s);
    % coord = strsplit(c, {'º', '´', '´´'});
    if c(1)=='-'
        sign = -1; ns = 'S';
    else
        sign = 1; ns = 'N';
    end
    
    [deg_s, rem] = strtok(c, 'º');
    [min_s, rem] = strtok(rem, '´');
    [sec_s, rem] = strtok(rem, '´´');

    if ismember('S', rem)
        sign = -1; ns = 'S';
    elseif ismember('N', rem)
        sign = 1; ns = 'N';
    end

    deg = abs(str2double(deg_s));
    min = str2double(erase(min_s,"º"));
    sec = str2double(erase(sec_s,"´"));

    if isnan(min), min=0;end
    if isnan(sec), sec=0;end

    coord_deg = (deg + min/60 + sec/3600);
    coord_rad = deg2rad(coord_deg);
else
    coord_rad = s;
    coord_deg = rad2deg(abs(coord_rad));
    deg = floor((coord_deg));
    min = mod(deg, 1)*60;
    sec = mod(min, 1)*60;
    if coord_rad < 0
        sign=-1; ns='S';
    else
        sign=1; ns='N';
    end
end
fprintf('\n\n_____________________________________\n');
fprintf('            LATITUDE\n');
fprintf('_____________________________________\n');
fprintf('±dd.dddddd°      ->  %3.6fº\n', sign*coord_deg);
fprintf('dd°mm.mmmm′N/S    ->  %02dº%2.4f′ %s\n', floor(coord_deg), mod(coord_deg, 1)*60, ns);
fprintf('dd.dddddd°N/S     ->  %3.6fº %s\n', (coord_deg), ns);
fprintf('dd°mm′ss.ss″N/S   ->  %02dº%02d′%2.2f′′ %s\n', floor(coord_deg), floor(mod(coord_deg, 1)*60), mod(coord_deg, 1/60)*3600, ns);
fprintf('±r.rrrrrrr rad°  ->  %1.7f rad\n', sign*coord_rad);
fprintf('_____________________________________\n');

% ±dd.dddddd°
% dd°mm.mmmm′N/S
% dd.dddddd°N/S
% dd°mm′ss.ss″N/S
% ±r.rrrrrrr rad

coord_rad = sign*coord_rad;
%%
end