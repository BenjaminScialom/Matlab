function [C] = reg_lin (x,y,q)
 

  
N = length(x);

J = zeros(N,q+1);

%% Matrice jacobienne 
J(:,1) = ones(N,1);

if q >= 1
J(:,2) = x;
end
if q >= 2
J(:,3) = x.^2;
end
if q >= 3
J(:,4) = x.^3;
end

C = inv(J'*J)*(J'*y');  %% inv(J'*J) * J'*y


  

end
