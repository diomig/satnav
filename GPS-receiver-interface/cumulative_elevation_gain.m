function cumulative_elevation_gain(nmea)

alt = nmea.gga.altitude;
utc = nmea.gga.utc;

alt1 = [alt; alt(end)];
alt2 = [alt(1); alt];

d = (alt1 - alt2);
asc = d>0;

figure(71);
plot(utc, alt,'LineWidth',1);hold on;
stem(utc(asc), alt(asc),'filled', 'LineStyle','none','MarkerSize',2);
hold off;

figure(72);
lat = nmea.gga.latitude;
lon = nmea.gga.longitude;
scatter(lon, lat, 20, (d(2:end)>0), 'filled');
cMap = interp1([0;1],[0.2 0.2 0.2; 0 1 0],linspace(0,1,256));
colormap(cMap);
colorbar

tolerance = (max(lon)-min(lon))*0.1;
xlim([min(lon)-tolerance max(lon)+tolerance]);
tolerance = (max(lat)-min(lat))*0.1;
ylim([min(lat)-tolerance max(lat)+tolerance]);


xticks([min(lon) max(lon)])
xticklabels({lon_format(abs(min(lon))),...
            lon_format(abs(max(lon)))})
yticks([min(lat) max(lat)])
yticklabels({lat_format(abs(min(lat))),...
            lat_format(abs(max(lat)))})
        
fprintf('\n\nCumulative Elevation Gain: %3.1f\n\n', sum(d(asc)))

end