function x_LS = least_squares(eph, t, indexes, r1, pseudoranges)


r = r1.xyz';
s = (sat_position_Tx(t, eph, indexes, r'))'; %clc;
e = (s-r)./vecnorm(s-r);
p = pseudoranges(indexes)';
eT_x_s = nonzeros(diag(e'*s)); 
z = p - eT_x_s;

H = [-e' ones(width(e), 1)];


x_LS = (H'*H)\H'*z;

end