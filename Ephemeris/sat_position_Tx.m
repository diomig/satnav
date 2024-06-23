% s = sat_position_Tx(t_rx, eph, index, r)
function s = sat_position_Tx(t_rx, eph, index, r)
    s = zeros(length(index), 3);
    i=1;
    for k = index
        s(i,:) = position_at_Tx(t_rx, eph, k, r);
        i=i+1;
    end

end