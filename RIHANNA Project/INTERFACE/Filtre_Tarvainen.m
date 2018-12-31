function [ Tfilt ] = Filtre_Tarvainen( T, lambda )
%An advanced detrending method with application to HRV analysis - Mika P. Tarvainen, Perttu O.Ranta-aho, and Pasi A.Karjalainen
 
l = length(T);
I = speye(l);
 
D = spdiags(ones(l-2,1)*[1 -2 1],0:2,l-2,l)
Tfilt = (I-inv(I+lambda^2*transpose(D)*D))*T;



end