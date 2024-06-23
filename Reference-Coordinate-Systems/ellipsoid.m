function e = ellipsoid()
%% WGS-84
e.wgs84.a =  6378137.0; %m
e.wgs84.f = 1/298.257223563;
e.wgs84.b = 6356752.3; %m
e.wgs84.e1 = 0.0818192;
e.wgs84.e2 = 0.0820944;
e.wgs84.alpha =  4.69314; %º
e.wgs84.ae = 521854; %m
    
%% PZ-90
e.pz90.a = 6378136.0; %m
e.pz90.f = 1/298.257839303;
e.pz90.b = 6356751.4; %m
e.pz90.e1 = 0.0818191;
e.pz90.e2 = 0.0820944;
e.pz90.alpha = 4.69314; %°
e.pz90.ae = 521853; %m



end