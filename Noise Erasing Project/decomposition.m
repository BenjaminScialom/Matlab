function [A] = decomposition (x,w,overlap)

% Initialisation des variables
L= length(w);
K = 1+floor((length(x))/(L-overlap));
x=x(:);
w=w(:);

% Initialisation de la matrice
A = zeros(L,K);
mat_tmp=zeros(L-overlap,K);
elem_miss=L-length(x(1+(K-1)*(L-overlap):end));
mat_tmp(1:end+overlap-elem_miss)=x(:);
A(1:L-overlap,:)=mat_tmp;

% Recouvrement
A(L-overlap+1:L,1:K-1)=mat_tmp(1:overlap,2:K);

% Fenetrage
W=repmat(w,1,K);
A=A.*W;

end
