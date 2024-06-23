function mat = enu2ecef_RM(p)
    mat = rotx(p.lat-pi/2)*rotz(-pi/2-p.lon);
end