function coord_rad = read_lon(s)
%% Example: s = "38º46´49.61´´N";

if isstring(s) || ischar(s)
    c = char(s);
    % coord = strsplit(c, {'º', '´', '´´'});
    if c(1)=='-'
        sign = -1; we = 'W';
    else
        sign = 1; we = 'E';
    end

    if ismember('W', c)
        sign = -1; we = 'W';
    elseif ismember('E', c)
        sign = 1; we = 'E';
    end

    [deg_s, rem] = strtok(c, 'º');
    [min_s, rem] = strtok(rem, '´');
    [sec_s, ~] = strtok(rem, '´´');

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
    deg = floor(coord_deg);
    min = mod(deg, 1)*60;
    sec = mod(min, 1)*60;
    if coord_rad < 0
        sign=-1; we='W';
    else
        sign=1; we='E';
    end
end
fprintf('\n\n_____________________________________\n');
fprintf('            LONGITUDE\n');
fprintf('_____________________________________\n');
fprintf('±ddd.dddddd°      ->  %3.6fº\n', sign*coord_deg);
fprintf('ddd°mm.mmmm′E/W    ->  %03dº%2.4f′ %s\n', floor(coord_deg), (mod(coord_deg, 1)*60), we);
fprintf('ddd.dddddd°E/W     ->  %3.6fº %s\n', (coord_deg), we);
fprintf('ddd°mm′ss.ss″E/W   ->  %03dº%02d′%2.2f′′ %s\n', floor(coord_deg), floor(mod(coord_deg, 1)*60), mod(coord_deg, 1/60)*3600, we);
fprintf('±r.rrrrrrr rad°  ->  %1.7f rad\n', sign*coord_rad);
fprintf('_____________________________________\n');

% ±ddd.dddddd°
% ddd°mm.mmmm′E/W
% ddd.dddddd°E/W
% ddd°mm′ss.ss″E/W
% ±r.rrrrrrr rad
 


coord_rad = sign*coord_rad;

end