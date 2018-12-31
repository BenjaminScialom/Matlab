function [Y_model] = model(C,X,q)
%% Evaluate the polynomial P at the specified values of X, the polynomial is evaluated for each of
%%    the elements of X.
%% INPUTS : 
%%        x : absis vector
%%        C : coefficients of the polynomial
%%        q : order of the regression
%% OUTPUTS : 
%%        Y_model : vector evaluate 

%% Different orders

% Order 1
  if q == 1
    
    a = C(2);
    b = C(1);
    
    Y_model = a.*X + b;
    
% Order 2 
  elseif q == 2
    
    a = C(3);
    b = C(2);
    c = C(1);
    
    Y_model = a.*X.^2 + b.*X + c;
    
% Order 2    
  elseif q == 3
    
    a = C(4);
    b = C(3);
    c = C(2);
    d = C(1);
    
    Y_model = a.*X.^3 + b.*X.^2 + c.*X + d;
    
    
  end


end
