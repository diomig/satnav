function str = lat_format(lat)

    ns = ['S' 'N'];                        

    if isscalar(lat)
        str = sprintf('%02dº%02.4f´, %s', floor(rad2deg(abs(lat))), mod(rad2deg(abs(lat)), 1)*60, ns((int8(lat)>0) +1));
    else
        lat_fmt = @(x) string([floor(rad2deg(abs(x))) + "º" + mod(rad2deg(abs(x)), 1) * 60 + "', " + ns(int8(x > 0) + 1)]);
        str = arrayfun(lat_fmt,lat);
    end


end