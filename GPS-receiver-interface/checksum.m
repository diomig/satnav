function [check] = checksum(nmea)

    [str, c] = strtok(nmea,'$*');
    str=uint8(str);
    chk=0;
    for i=1:size(str,2)
        chk=bitxor(chk,str(i));
    end
    chk=dec2hex(chk,2);

    check = strcmp(chk,c(2:end));
    
end