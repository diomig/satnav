function coord_rad = coordinate_formats(c)

coord = strsplit(c, {'º', '´', '´´'});
deg = str2double(coord(1));
min = str2double(coord(2));
sec = str2double(coord(3));
sign = (coord(4)=='N')*2-1;

coord_deg = sign*(deg + min/60 + sec/3600);
coord_rad = deg2rad(coord_deg);

fprintf('\n\n_____________________________________\n');
fprintf('            LATITUDE\n');
fprintf('_____________________________________\n');
fprintf('±dd.dddddd°      ->  %3.6fº\n', coord_deg);
fprintf('dd°mm.mmmm′N/S    ->  %02dº%2.4f\n', deg, min+sec/60);
fprintf('dd.dddddd°N/S     ->  %3.6fº%s\n', coord_deg, coord(4));
fprintf('dd°mm′ss.ss″N/S   ->  %02dº%02d′%2.2f′′%s\n', deg, min, sec, coord(4));
fprintf('±r.rrrrrrr rad°  ->  %1.7f rad\n', coord_rad);
fprintf('_____________________________________\n');

% ±dd.dddddd°
% dd°mm.mmmm′N/S
% dd.dddddd°N/S
% dd°mm′ss.ss″N/S
% ±r.rrrrrrr rad



end