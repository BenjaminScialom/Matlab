function [Y_model] = model(C,X,q)

  if q == 1
    
    a = C(2);
    b = C(1);
    
    Y_model = a.*X + b;
    
    
  elseif q == 2
    
    a = C(3);
    b = C(2);
    c = C(1);
    
    Y_model = a.*X.^2 + b.*X + c;
    
    
  elseif q == 3
    
    a = C(4);
    b = C(3);
    c = C(2);
    d = C(1);
    
    Y_model = a.*X.^3 + b.*X.^2 + c.*X + d;
    
    
  end


end
