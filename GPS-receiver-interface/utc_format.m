function [str] = utc_format(utc)

if isscalar(utc)
    str =  sprintf('%02d:%02d:%02d.%03d', int8(utc/10000), mod(floor(utc/100), 100),...
                            mod(floor(utc), 100), mod((utc)*1000, 1000));

else
    utc_fmt = @(x) datestr(datenum( string(x), 'HHMMSS' ) - datenum( '000000', 'HHMMSS' ), 'HH:MM:SS');
    str = utc_fmt(utc);
end