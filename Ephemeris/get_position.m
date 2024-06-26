%coord = get_position(eph, index, time)
function coord = get_position(eph, index, time)
  wn = time.wn; tow = time.tow;
  values.sv = eph.sv(index);

  values.dt = (wn * 604800 + tow) - (eph.wn(index) * 604800+ eph.toe(index));
      
  mu = 3.986005e14; %m^3/s^-2
  values.motion = sqrt(mu./eph.A(index).^3) + eph.dn(index);


  values.M = eph.Mo(index) + values.motion.*values.dt;

  [values.E, values.iter] = eccentric_anomaly(values.M, eph.e(index));

  values.phi0 = 2*atan(sqrt((1+eph.e(index))./(1-eph.e(index))) .* tan(values.E./2));

  values.arglat = values.phi0 + eph.argper(index);

  values.u = values.arglat + (eph.Cuc(index).*cos(2*values.arglat) + eph.Cus(index).*sin(2*values.arglat));


  values.r0 = eph.A(index) .* (1 - eph.e(index).*cos(values.E));

  values.r = values.r0 + (eph.Crc(index).*cos(2*values.arglat) + eph.Crs(index).*sin(2*values.arglat));

  values.i = eph.io(index) + (eph.Cic(index).*cos(2*values.arglat) + eph.Cis(index).*sin(2*values.arglat)) + eph.idot(index).*values.dt;

  OmegaDot_e = 7.2921151467e-5;
  values.Omega = eph.Omega0(index) + (eph.OmegaDot(index) - OmegaDot_e).*values.dt - OmegaDot_e*eph.toe(index);

  vec = [values.r.*cos(values.u) values.r.*sin(values.u) zeros(size(values.u))];
  values.coordinates = zeros(size(vec));

  for k=1:length(eph.sv(index))
      values.coordinates(k,:) = vec(k,:)*rotx(-values.i(k))*rotz(-values.Omega(k));
  end

  coord = values.coordinates;
end
