function dt = time_of_anomaly(eph, true_anomaly)
    mu = 3.986005e14;
    n = sqrt(mu/eph.A^3) + eph.dn;

    E=2*atan2(tan(true_anomaly/2),(sqrt((1+eph.e)/(1-eph.e))));
    E = wrapTo2Pi(E); 
    M = E-eph.e*sin(E);

    dt = (M - eph.Mo)/n;

    fprintf('\nTOW = %.2fs\n\n', dt)

end