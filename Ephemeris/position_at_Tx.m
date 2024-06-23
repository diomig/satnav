%s_tx = position_at_Tx(t_rx, eph, sat, r1)
function s_tx = position_at_Tx(t_rx, eph, sat, r1)

c = 299792458; OmegaDot_e = 7.2921151467e-5;
tol = 1e-3; maxIter = 100;
d_ = 0;
i = 1;
while i<maxIter

d = d_;
t_tx.tow = t_rx.tow - d/c;
t_tx.wn = t_rx.wn;
s_tx = get_position(eph, sat, t_tx);

% fprintf('\n\n\nIteration %d: \n', i);
% fprintf('t = %.9f\n', t_tx);
% fprintf('s = (%.3f, %.3f, %.3f)\n', s_tx);

dOmega = OmegaDot_e * d/c;

s_tx = s_tx * rotz(dOmega);

d_ = norm(s_tx - r1);


% fprintf('∆Ω = %.2f rad\n', dOmega);
% fprintf('s = (%.3f, %.3f, %.3f)\n', s_tx);
% fprintf('∆dsr = %.6f\n', d-d_);

if abs(d-d_)<tol
    break;
end
i = i+1;
end


end