function llh = xyz2llh(xyz, datum)
% 
% x = xyz(1); y = xyz(2); z = xyz(3);
% 
% %% Vermeille’s Method
% 
% if y>=0
%     lon = pi/2 - 2*atan2(x,(sqrt(x^2+y^2)+y));
% else
%     lon = -pi/2 + 2*atan2(x,(sqrt(x^2+y^2)-y));
% end
% 
% %% Bowring's Method
% p = sqrt(x^2+y^2);
% 
% beta = atan(datum.a/datum.b * z/p);
% 
% lat = atan2((z+(datum.e2)^2*datum.b*(sin(beta))^3), (p-(datum.e1)^2*datum.a*(cos(beta))^3));
% 
% 
% 
% RN = datum.a/(sqrt(1-datum.f*(2-datum.f)*(sin(lat))^2));
% 
% alt = p*(cos(lat)) + z*sin(lat) - (datum.a^2)/RN;
% 
% llh = [lat, lon, alt];




x = xyz(:,1); y = xyz(:,2); z = xyz(:,3);

%% Vermeille’s Method

if y>=0
    lon = pi/2 - 2*atan2(x,(sqrt(x.^2+y.^2)+y));
else
    lon = -pi/2 + 2*atan2(x,(sqrt(x.^2+y.^2)-y));
end

%% Bowring's Method
p = sqrt(x.^2+y.^2);

beta = atan(datum.a/datum.b .* z./p);

lat = atan2((z+(datum.e2)^2*datum.b.*(sin(beta)).^3), (p-(datum.e1)^2.*datum.a.*(cos(beta)).^3));



RN = datum.a./(sqrt(1-datum.f*(2-datum.f)*(sin(lat)).^2));
 
alt = p.*(cos(lat)) + z.*sin(lat) - (datum.a^2)./RN;

llh = [lat, lon, alt];

end