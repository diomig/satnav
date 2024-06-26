function HDOP = hdop(t, eph, indexes, r1)

  r = r1.xyz';

  s = sat_position_Tx(t, eph, eph.all, r')';
  e = (s-r)./vecnorm(s-r);

  e_ = e(:, indexes);

  % H = [-e_' ones(width(e_), 1)];
  % M = inv(H'*H);
  % pdop = sqrt(trace(M(1:3,1:3)));
   

  H_enu = [-e_'*ecef2enu_RM(r1) ones(width(e_), 1)];
  M_enu = inv(H_enu' * H_enu);
  HDOP = sqrt(trace(M_enu(1:2,1:2)));

end
