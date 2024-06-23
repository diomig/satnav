function [az, el] = az_el(enu)

e=enu(1);n=enu(2);u=enu(3);

az = atan2(e,n);
el = atan2(u,sqrt(n^2+e^2));

fprintf('\nAzimuth: %3.1fº\n', rad2deg(az));
fprintf('Elevation: %3.1fº\n', rad2deg(el));


end