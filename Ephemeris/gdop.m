function GDOP = gdop(t, eph, indexes, r1)

  r = r1.xyz';

  s = sat_position_Tx(t, eph, eph.all, r')';
  e = (s-r)./vecnorm(s-r);

  e_ = e(:, indexes);

  H = [-e_' ones(width(e_), 1)];
  M = inv(H'*H);
  GDOP = sqrt(trace(M));
    
   
end
