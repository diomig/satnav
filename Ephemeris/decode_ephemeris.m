function eph = decode_ephemeris(file)
    eph_table = load(file);
    [n, ~] = size(eph_table);
    eph.all = 1:n;
    
    eph.sv = eph_table(:,1);
    eph.iode2 = eph_table(:,2);
    eph.iode3 = eph_table(:,3);
    %THIS MAY NOT APPLY (só para safar no teste)
    %(se for maior que este threshold, provavlemente 
    %ainda vai no 1º rollover)
    if eph_table(1,4) > 200   
        eph.wn = eph_table(:,4) + 1024;
    % caso contrário, provavlemente vai no 2º rollover
    else 
        eph.wn = eph_table(:,4) + 2048;
    end
    eph.toe = eph_table(:,7);
    eph.fif = eph_table(:,8);
    eph.health = eph_table(:,10);
    eph.ura = eph_table(:,11);
    eph.alert = eph_table(:,12);
    eph.anti_spoof = eph_table(:,13);
    eph.L2code = eph_table(:,14);
    eph.tgd = eph_table(:,16);
    eph.iodc = eph_table(:,19);
    eph.iodc = eph_table(:,19);
    eph.toc = eph_table(:,21);
    eph.A = eph_table(:,34).^2; 
    eph.dn = eph_table(:,37);
    eph.Mo = eph_table(:,40);
    eph.e = eph_table(:,43);
    eph.argper = eph_table(:,46);
    eph.io = eph_table(:,49);
    eph.idot = eph_table(:,52);
    eph.Omega0 = eph_table(:,55);
    eph.OmegaDot = eph_table(:,58);
    eph.Cuc = eph_table(:,61);
    eph.Cus = eph_table(:,64);
    eph.Crc = eph_table(:,67);
    eph.Crs = eph_table(:,70);
    eph.Cic = eph_table(:,73);
    eph.Cis = eph_table(:,76);
    
    
    eph.time = eph.wn*(3600*24*7) + eph.toe;


end