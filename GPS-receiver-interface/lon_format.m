function str = lon_format(lon)

    we = ['W' 'E'];

    if isscalar(lon)
        str = sprintf('%03dº%02.4f´, %s', floor(rad2deg(abs(lon))), mod(rad2deg(abs(lon)), 1)*60, we((int8(lon)>0) +1));
    else
        lon_fmt = @(x) string([floor(rad2deg(abs(x))) + "º" + mod(rad2deg(abs(x)), 1) * 60 + "′, " + we(int8(x > 0) + 1)]);
        str = arrayfun(lon_fmt,lon);
    end
end