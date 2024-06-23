function llh2 = molodensky(llh1, datum1, param)

phi = llh1(1);
lambda = llh1(2);
h = llh1(3);

da=param.da; df=param.df; dX=param.dx; dY=param.dy; dZ=param.dz;

a=datum1.a; e=datum1.e1;
b=datum1.b; 

RN = a / (sqrt(1-e^2*sin(phi)^2));
RM = a*(1-e^2)  / (sqrt((1-e^2*(sin(phi))^2)^3));

d_phi = (-dX*sin(phi)*cos(lambda) - dY*sin(phi)*sin(lambda) + dZ*cos(phi) + (da*RN*e^2/a + df*(RM*a/b + RN*b/a))*sin(phi)*cos(phi))/(RM + h);
d_phi_sec = rad2deg(d_phi)*3600;

d_lambda = (-dX*sin(lambda) + dY*cos(lambda)) / ((RN+h)*cos(phi));
d_lambda_sec = rad2deg(d_lambda)*3600;

d_h = dX*cos(phi)*cos(lambda) + dY*cos(phi)*sin(lambda) + dZ*sin(phi) - da*a/RN + df*b/a*RN*sin(phi)^2;

d = [d_phi d_lambda d_h];

llh2 = llh1 + d;



fprintf('\n[d_phi, d_lambda, d_h] = [%frad %frad %3.1fm]\n', d_phi, d_lambda, d_h);
fprintf('                       = [%1.2f′′ %1.2f′′ %3.1fm]\n', d_phi_sec, d_lambda_sec, d_h);

% clear phi lambda h
% clear da df dX dY dZ
% clear a b e1
% clear RN RM

end