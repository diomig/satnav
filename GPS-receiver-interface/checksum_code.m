function [chk] = checksum_code(nmea)

    [str, ~] = strtok(nmea,'$*');
    str=uint8(str);
    chk=0;
    for i=1:size(str,2)
        chk=bitxor(chk,str(i));
    end
    chk=dec2hex(chk,2);
    
end