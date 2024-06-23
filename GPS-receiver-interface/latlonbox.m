function latlonbox(nmea)

lat = nmea.gga.latitude; lon = nmea.gga.longitude;

str = sprintf([ 'LATITUDE:\n'...
                '\tMIN -> %s \n\tMAX -> %s'...
                '\n\nLONGITUDE:\n'...
                '\tMIN -> %s \n\tMAX -> %s'], ...
                lat_format(min(lat)), ...
                lat_format(max(lat)), ...
                lon_format(min(lon)), ...
                lon_format(max(lon)));

fprintf('\n\n==============================\n');
disp(str)       
% ~~~~~~~~~~~~~~~~~~~~~~~~Plot map~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
speedK = nmea.rmc.speedN * 1.852;

f = figure(5);
s=scatter(lon, lat, 20, speedK, 'filled');
colorbar;

lat_dt = lat_format(lat);
lon_dt = lon_format(lon);

patch(  [min(lon) min(lon) max(lon) max(lon)],... 
        [min(lat) max(lat) max(lat) min(lat)],... 
        'k','FaceColor','none', 'Marker', 'x', ...
        'LineStyle', ':');
tolerance = (max(lon)-min(lon))*0.1;
xlim([min(lon)-tolerance max(lon)+tolerance]);
tolerance = (max(lat)-min(lat))*0.1;
ylim([min(lat)-tolerance max(lat)+tolerance]);
speedDT = dataTipTextRow('Vel',speedK);
timeDT = dataTipTextRow('Timer',string(utc_format(nmea.rmc.utc)));
latDT = dataTipTextRow('Lat',lat_dt);
lonDT = dataTipTextRow('Lon',lon_dt);
s.DataTipTemplate.DataTipRows = [speedDT, timeDT, latDT, lonDT];
f.Units = 'normalized';
f.Position(3) = .6;

a = gca; % get the current axis;
a.Position(3) = 0.6;
annotation('textbox', [0.8, 0.5, 0.1, 0.1], ...
'String', str, ...
'Color', [0 0.5 1], ...
'FontWeight', 'bold', ...
'EdgeColor', 'k', ...
'FitBoxToText','on');
xticks([min(lon) max(lon)])
xticklabels({lon_format(abs(min(lon))),...
            lon_format(abs(max(lon)))})
yticks([min(lat) max(lat)])
yticklabels({lat_format(abs(min(lat))),...
            lat_format(abs(max(lat)))})
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


clear lat lon we ns str a p f s
clear speedDT timeDT latDT lonDT
clear speedK tolerance 
clear lat_dt  lon_dt 

end