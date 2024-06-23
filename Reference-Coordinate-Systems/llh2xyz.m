function xyz=llh2xyz(llh,datum)
% LLH2XYZ Geodetic to cartesian coordinates.
% xyz=LLH2XYZ(llh,a,f) converts the geodetic coordinates
% (latitude,longitude,height), in the (1x3) llh row vector,
% to cartesian coordinates (x,y,z), returned in the (1x3) 
% xyz row vector, based on an ellipsoid with semi-major
% axis a and flattening f.
% Parameters a and f are scalar. Multiple n row vectors
% can be converted if llh is a (nx3) matrix.
% The following document contain ellipsoidal parameters a 
% and f that can be used in this conversion:
% Department of Defense World Geodetic System 1984.
% NIMA TR8350.2. Third Edition. 4 July 1997.
% Units:
% lat radians [-Pi/2,Pi/2]
% lon radians [-Pi,Pi]
% height meters
% x,y,z meters
% a meters
% f no units
a = datum.a;
f = datum.f;
coslat=cos(llh(:,1));
sinlat=sin(llh(:,1));
RN=a./sqrt(1-f*(2-f)*sinlat.^2);
xyz(:,1)=(RN+llh(:,3)).*coslat.*cos(llh(:,2));
xyz(:,2)=(RN+llh(:,3)).*coslat.*sin(llh(:,2));
xyz(:,3)=((1-f)^2*RN+llh(:,3)).*sinlat;
return

end
