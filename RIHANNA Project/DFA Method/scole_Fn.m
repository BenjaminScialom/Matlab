function [Fn] = scole_Fn(Y,D_s)
  
 [N,~] = size(Y);
 
Fn = zeros(1,N);
for kk=1:N
  yfit=Y(kk,:);
  Fn(1,kk)=sqrt((1/N)*sum((D_s(kk,:)-yfit(1,:)).^2));
end

end
