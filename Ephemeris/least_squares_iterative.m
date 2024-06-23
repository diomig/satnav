%least_squares(t_tx, eph, r, pseudoranges)
function least_squares_iterative(t_tx, eph, r1, pseudoranges)

r = r1.xyz';
i = 1; max_iter = 100;
while i < max_iter
    s = sat_position_Tx(t_tx, eph, eph.all, r')'; %clc;
    e = (s-r)./vecnorm(s-r);
    p = pseudoranges(:,1);

    z = p - diag(e'*s);

    H = [-e' ones(width(e), 1)];

    x_ls = (H'*H)\ H' * z;
    
    if norm(r-x_ls(1:3)) < 1e-3
        break;
    end
    r=x_ls(1:3);
    i = i+1;
end

fprintf('x_LS = (%.3f m, %.3f m, %.3f m)\nc.∆t = %.4f\n', x_ls);
fprintf('# iterations: %d\n\n', i)
