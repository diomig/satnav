% EXERCISE COLLECTION 2
clear
%% Exercise 1 – Degrees, Minutes and Seconds
clc;
%p1 = (38º 46´ 49.61´´ N, 9º 29´ 56.19´´ W, 103 m)

lat_s = "38º46´49.61´´N";
lon_s = "9º29´56.19´´ W";
alt  = 103;

p1.lat = read_lat(lat_s);
p1.lon = read_lon(lon_s);
p1.alt = alt;
p1.llh = [p1.lat p1.lon p1.alt];


clear lat_s lon_s alt
%% Exercise 2 – WGS 84 Geodetic to Cartesian Coordinates
format long
datum = ellipsoid().wgs84;
% a = 6378137.0;
% f = 1/298.257223563;
p1.llh = [p1.lat p1.lon p1.alt];
p1.xyz = llh2xyz(p1.llh, datum);

fprintf('\n\n')
disp(p1.xyz)


%% Exercise 3 – WGS 84 Cartesian to Geodetic Coordinates

we = ['W' 'E'];
ns = ['S' 'N'];                        

datum = ellipsoid().wgs84;
%p2 = (4910384.3 m, -821478.6 m, 3973549.6 m)
p2.xyz = [4910384.3 -821478.6 3973549.6];
p2.llh = xyz2llh(p2.xyz, datum);

clc;

% 3a
lat_format = @(x)  sprintf('%02.6fº %s', (rad2deg(abs(x))), ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03.6fº %s', (rad2deg(abs(x))), we((int8(x)>0) +1));
fprintf('\n3.a) p1 = (%s , %s , %3.1f)\n', lat_format(p2.llh(1)), lon_format(p2.llh(2)), p2.llh(3))

% 3b
lat_format = @(x)  sprintf('%02dº%02.4f´ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02.4f´ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, we((int8(x)>0) +1));
fprintf('\n3.a) p1 = (%s , %s , %3.1f)\n', lat_format(p2.llh(1)), lon_format(p2.llh(2)), p2.llh(3))

% 3c
lat_format = @(x)  sprintf('%02dº%02d´%02.2f´´ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02d´%02.2f´´ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, we((int8(x)>0) +1));
fprintf('\n3.a) p1 = (%s , %s , %3.1f)\n', lat_format(p2.llh(1)), lon_format(p2.llh(2)), p2.llh(3))

p2.x = p2.xyz(1);  p2.y = p2.xyz(2); p2.z = p2.xyz(3);
%p2.lat = lat2; p2.lon = lon2; p2.alt = alt;
%p2.llh=[p2.lat p2.lon p2.alt];

clear alt lat_format lon_format we ns datum

%% Exercise 4 – Distances

format short
dist = norm(p1.xyz-p2.xyz);

fprintf('\nDistance between p1 and p2: %.1f m\n\n', dist)

clear dist

%% Exercise 5 – Datum Transformations (Molodensky)
%parameters for conversion from WGS84 to ED50 
%(simmetric to the parameters for ED50->WGS84)
param.da = 251; %m
param.df = 0.14192702e-4;
param.dx = 84; %m
param.dy = 107; %m 
param.dz = 120; %m

we = ['W' 'E'];
ns = ['S' 'N'];  


wgs84 = ellipsoid().wgs84;
ed50 = wgs84; ed50.a = wgs84.a + param.da; ed50.f = wgs84.f + param.df;

fprintf('\n\n\n')
clc
fprintf('====================================================\n');
fprintf('Molodensky transformation - p1\n');
fprintf('----------------------------------------------------');

p1_ed50M.llh = molodensky(p1.llh, wgs84, param);
p1_ed50M.xyz = llh2xyz(p1_ed50M.llh, ed50);

fprintf('\n Geodetic Coordinates:')
p = p1_ed50M;
lat_format = @(x)  sprintf('%02.6fº %s', (rad2deg(abs(x))), ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03.6fº %s', (rad2deg(abs(x))), we((int8(x)>0) +1));
fprintf('\n p1[ED-50] = (%s , %s , %3.1f)\n', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
lat_format = @(x)  sprintf('%02dº%02.4f′ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02.4f′ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, we((int8(x)>0) +1));
fprintf('           = (%s , %s , %3.1f)\n', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
lat_format = @(x)  sprintf('%02dº%02d′%02.2f′′ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02d′%02.2f′′ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, we((int8(x)>0) +1));
fprintf('           = (%s , %s , %3.1f)\n', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
fprintf('\n Cartesian Coordinates:')
fprintf('\n p1[Ed-50] = (%.1fm %.1fm %.1fm)', p.xyz)

fprintf('\n====================================================\n');
fprintf('Molodensky transformation - p2\n');
fprintf('----------------------------------------------------');

p2_ed50.llh = molodensky(p2.llh, wgs84, param);
p2_ed50.xyz = llh2xyz(p2_ed50.llh, ed50);

p = p2_ed50;
lat_format = @(x)  sprintf('%02.6fº %s', (rad2deg(abs(x))), ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03.6fº %s', (rad2deg(abs(x))), we((int8(x)>0) +1));
fprintf('\n p2[ED-50] = (%s , %s , %3.1f)', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
lat_format = @(x)  sprintf('%02dº%02.4f′ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02.4f′ %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, we((int8(x)>0) +1));
fprintf('\n           = (%s , %s , %3.1f)', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
lat_format = @(x)  sprintf('%02dº%02d′%02.2f′′ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, ns((int8(x)>0) +1));
lon_format = @(x)  sprintf('%03dº%02d′%02.2f′′ %s', floor(rad2deg(abs(x))), floor(mod(rad2deg(abs(x)), 1)*60), mod(mod(rad2deg(abs(x)), 1)*60, 1)*60, we((int8(x)>0) +1));
fprintf('\n           = (%s , %s , %3.1f)\n', lat_format(p.llh(1)), lon_format(p.llh(2)), p.llh(3))
fprintf('\n Cartesian Coordinates:')
fprintf('\n p2[Ed-50] = (%.1fm %.1fm %.1fm)', p.xyz)
fprintf('\n')



% Exercise 5 – Datum Transformations

fprintf('\n====================================================\n');
fprintf('CARTESIAN TRANSLATION - p1\n');
fprintf('----------------------------------------------------\n');

%P_wgs84 = P_local + [dx dy dz]  =>
% => P_local = P_wgs84 - [dx dy dz]
p1_ed50.xyz = p1.xyz + [param.dx param.dy param.dz];
p1_ed50.llh = xyz2llh(p1_ed50.xyz, ed50);

p = p1_ed50;
fprintf('p1[Ed-50] = (%.1fm %.1fm %.1fm)\n', p.xyz)             

dist = norm(p1_ed50M.xyz - p1_ed50.xyz);
fprintf('\n\n||p1_ed50[Molodensky] - p1_ed50|| = %fm\n\n', dist)


clear param p dist ed50 wgs84
clear we ns lat_format lon_format

%% Exercise 6 – Azimuth and Elevation

d = p2.xyz - p1.xyz;
r = norm(d)*0.3;
enu = d*ecef2enu_RM(p1);
e=enu(1);n=enu(2);u=enu(3);

east=[r 0 0]*ecef2enu_RM(p1)';
north=[0 r 0]*ecef2enu_RM(p1)';
up=[0 0 r]*ecef2enu_RM(p1)';

az = atan2(e,n);
el = atan2(u,sqrt(n^2+e^2));

fprintf('\nAzimuth: %3.1fº\n', rad2deg(az));
fprintf('Elevation: %3.1fº\n', rad2deg(el));
% Create a figure
figure(6);
% Plot the 3D vector using quiver3
x=[p1.xyz(1) p1.xyz(1) p1.xyz(1)]; y=[p1.xyz(2) p1.xyz(2) p1.xyz(2)]; z=[p1.xyz(3) p1.xyz(3) p1.xyz(3)];
x1=[r 0 0]; y1=[0 r 0]; z1=[0 0 r];
x2 = [east(1) north(1) up(1)]; y2=[east(2) north(2) up(2)]; z2=[east(3) north(3) up(3)];
clf;hold on;
%plot axis
quiver3(x, y, z, x1, y1, z1, 'b') %sistema de eixos ECEF
quiver3(x, y, z, x2, y2, z2, 'r') %sistema de eixos ENU
text(x+x1,y+y1,z+z1, ["x" "y" "z"],'Color', 'blue', 'FontSize', 12)
text(x+x2,y+y2,z+z2, ["e" "n" "u"],'Color', 'red', 'FontSize', 12)
fill3([x x+east(1) x+north(1)], ...
      [y y+east(2) y+north(2)], ...
      [z z+east(3) z+north(3)], ...
      'g')
%plot p2-p1 vector
quiver3(p1.xyz(1), p1.xyz(2), p1.xyz(3), d(1), d(2), d(3), 'b', 'LineWidth', 2, 'LineStyle', '-.'); 
%quiver3(p1.xyz(1), p1.xyz(2), p1.xyz(3), enu(1), enu(2), enu(3), 'r', 'LineWidth', 2); hold on;

hold off;
% Set axis labels and title
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Vector Visualization');
% Optionally, set axis limits based on your data
% axis([xmin, xmax, ymin, ymax, zmin, zmax]);
grid on;
axis equal;
view(3); % 3D view
% hold on
% [Xs,Ys,Zs] = sphere;
% Xs = (Xs*r+p1.xyz(1))-x2(1)*r;
% Ys = (Ys*r+p1.xyz(2))-y2(1)*r;
% Zs = (Zs*r+p1.xyz(3))-z2(1)*r;
% surf(Xs, Zs, Ys);
% hold off


%% enu to ecef

xyz = enu*enu2ecef_RM(p1);

%% FORMATS
% lat_format = @(x)  sprintf('%02dº%02.4f´, %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, ns((int8(x)>0) +1));
% lon_format = @(x)  sprintf('%03dº%02.4f´, %s', floor(rad2deg(abs(x))), mod(rad2deg(abs(x)), 1)*60, we((int8(x)>0) +1));
% lat_fmt = @(x) string([floor(rad2deg(abs(x))) + "º" + mod(rad2deg(abs(x)), 1) * 60 + "', " + ns(int8(x > 0) + 1)]);
% lon_fmt = @(x) string([floor(rad2deg(abs(x))) + "º" + mod(rad2deg(abs(x)), 1) * 60 + "', " + we(int8(x > 0) + 1)]);
