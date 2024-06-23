function mat = ecef2enu_RM(p)
    mat = rotz(p.llh(2)+pi/2)*rotx(pi/2-p.llh(1));
end