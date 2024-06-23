function RN = curvature_radius(lat, datum)
a=datum.a;
f=datum.f;

RN=a./sqrt(1-f*(2-f)*sin(lat).^2);


end