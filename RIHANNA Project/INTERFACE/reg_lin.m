function [C] = reg_lin (x,y,q)
%% Return the coefficients of a polynomial P(X) of degree q that
%% minimizes the least-squares-error of the fit to the points 
%% '[x,y]'.
%% INPUTS : 
%%        x : absis vector
%%        y : ordonate vector
%%        q : order of the regression
%% OUTPUTS : 
%%        C : coefficients of the polynomial

  
N = length(x);

J = zeros(N,q+1);

%% Jacob matrix : linearized model operator 
J(:,1) = ones(N,1);

%% Filling J according to the order 
% Order 1
if q >= 1
J(:,2) = x;
end

%Order 2
if q >= 2
J(:,3) = x.^2;
end

% Order 3
if q >= 3
J(:,4) = x.^3;
end

%% Coefficients calculation
C = inv(J'*J)*(J'*y');  %% inv(J'*J) * J'*y


  

end
