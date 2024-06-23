function plot_speed(nmea)

speedK = nmea.rmc.speedN * 1.852;
lat = nmea.rmc.latitude;
lon = nmea.rmc.longitude;
f = figure(8);

[max_speed, pnt] = max(speedK);

str = sprintf('MAX SPEED: \n%2.1f Km/h', ...
                max_speed);

s = scatter(lon, lat, 20, speedK, 'filled');hold on;
s_max =scatter(lon(pnt), lat(pnt), 80, 's', 'r');hold off;
colormap parula
colorbar;

lat_dt = lat_format(lat);
lon_dt = lon_format(lon);


tolerance = (max(lon)-min(lon))*0.1;
xlim([min(lon)-tolerance max(lon)+tolerance]);
tolerance = (max(lat)-min(lat))*0.1;
ylim([min(lat)-tolerance max(lat)+tolerance]);

speedDT = dataTipTextRow('Vel',max_speed);
timeDT = dataTipTextRow('Time',string(utc_format(nmea.rmc.utc(pnt:end))));
latDT = dataTipTextRow('Lat',string(lat_format(nmea.rmc.latitude(pnt:end))));
lonDT = dataTipTextRow('Lon',string(lon_format(nmea.rmc.longitude(pnt:end))));
s_max.DataTipTemplate.DataTipRows = [speedDT, timeDT, latDT, lonDT];

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

fprintf("\n%s\n\n", str)


xticks([min(lon) max(lon)])
xticklabels({lon_format(abs(min(lon))),...
            lon_format(abs(max(lon)))})
yticks([min(lat) max(lat)])
yticklabels({lat_format(abs(min(lat))),...
            lat_format(abs(max(lat)))})

end