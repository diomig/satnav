function [E, i] = eccentric_anomaly(M, e)

  tol = 1e-12; maxIter = 100;
  E = M;
  i = ones(size(M));
  while max(i)<maxIter

    E_ = E;
    % E = M + e .* sin(E);
    E = E - (E - M - e.*sin(E))./(1-e.*cos(E));

    if abs(E-E_)<tol
        break;
    end
    i = i+double(abs(E-E_)>tol);
  end

end




