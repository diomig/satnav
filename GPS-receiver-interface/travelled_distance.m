function [sum] = travelled_distance(gga, datum)

lat = gga.latitude;
lon = gga.longitude;
alt = gga.altitude + gga.geoid_height;
xyz = llh2xyz([lat lon alt], datum);

d = diff(xyz);

sum = 0;
for k = 1:length(d)
    sum = sum + norm(d(k,:));
end

fprintf('\n\nTravelled distance: %.1f m\n\n', sum)
fprintf('(%d points)\n\n\n', length(d)+1)
end



