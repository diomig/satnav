function index = svnindex(eph, sats)

  index = find(eph.sv==sats)' - (0:8:8*(length(sats)-1));


end
