function plot_altitude(nmea)

alt = nmea.gga.altitude;
lat = nmea.gga.latitude;
lon = nmea.gga.longitude;
utc = nmea.gga.utc;

                       
[low_alt, low_p] = min(alt);
low_lat = lat(low_p); low_lon = lon(low_p);low_utc = utc(low_p);

[high_alt, high_p] = max(alt);
high_lat = lat(high_p); high_lon = lon(high_p);high_utc = utc(high_p);
                        
disp(' ')
fprintf('      Lowest Point    |    Highest point\n')
fprintf('      ----------------|-----------------\n')
fprintf('ALT       %2.1f m      |       %2.1f m\n', low_alt, high_alt)
fprintf('LAT    %s |    %s\n', lat_format(low_lat), lat_format(high_lat))
fprintf('LON   %s |   %s\n', lon_format(low_lon), lon_format(high_lon))
fprintf('UTC     %s  |     %s\n', utc_format(low_utc), utc_format(high_utc))
fprintf('LINE      %d       |       %d\n', nmea.gga.num(low_p), nmea.gga.num(high_p))


figure(6);
lat = nmea.gga.latitude;
lon = nmea.gga.longitude;
s = scatter(lon, lat, 20, nmea.gga.altitude, 'filled');hold on

tolerance = (max(lon)-min(lon))*0.1;
xlim([min(lon)-tolerance max(lon)+tolerance]);
tolerance = (max(lat)-min(lat))*0.1;
ylim([min(lat)-tolerance max(lat)+tolerance]);



colormap winter;
colorbar;
% waypoints
altDT = dataTipTextRow('Alt',alt);
timeDT = dataTipTextRow('Time',string(utc_format(nmea.gga.utc)));
latDT = dataTipTextRow('Lat',lat_format(lat));
lonDT = dataTipTextRow('Lon',lon_format(lon));
s.DataTipTemplate.DataTipRows = [altDT, timeDT, latDT, lonDT];

%% high point
s_high = scatter(high_lon, high_lat, 100, "^", 'filled', 'r');
altDT = dataTipTextRow('Alt',high_alt);
timeDT = dataTipTextRow('Time',string(utc_format(nmea.gga.utc(high_p:end))));
latDT = dataTipTextRow('Lat',string(lat_format(nmea.gga.latitude(high_p:end))));
lonDT = dataTipTextRow('Lon',string(lon_format(nmea.gga.longitude(high_p:end))));
s_high.DataTipTemplate.DataTipRows = [altDT, timeDT, latDT, lonDT];

 
%% low point
s_low = scatter(low_lon, low_lat, 100, "v", 'filled', 'r');
altDT = dataTipTextRow('Alt',low_alt);
timeDT = dataTipTextRow('Time',string(utc_format(nmea.gga.utc(low_p:end))));
latDT = dataTipTextRow('Lat',string(lat_format(nmea.gga.latitude(low_p:end))));
lonDT = dataTipTextRow('Lon',string(lon_format(nmea.gga.longitude(low_p:end))));
s_low.DataTipTemplate.DataTipRows = [altDT, timeDT, latDT, lonDT];

xticks([min(lon) max(lon)])
xticklabels({lon_format(abs(min(lon))),...
            lon_format(abs(max(lon)))})
yticks([min(lat) max(lat)])
yticklabels({lat_format(abs(min(lat))),...
            lat_format(abs(max(lat)))})
hold off

end