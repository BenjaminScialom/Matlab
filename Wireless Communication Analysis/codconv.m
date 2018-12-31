% P. Vallet (Bordeaux INP)
% TP codes convolutifs

function [c] = codconv(m,g)
% m : vector of int representing the binary message.
% g : vectors with entries in octal representing the polynomial generators of a dimension 1 convolutional code. 
% c : vector of int representing the codeword generated from m and g.
[G,M, T] = paramconv(g);
n=length(g); % Length of the code
L=length(m); % Length of the message
% Matrix of coded sequence (row j contains the coefficients of m(D) g_i(D))
% where g_i(D) is the i-th generator polynomial
C=zeros(n,L+M);
for j=1:n
     C(j,:) = conv(m,G(j,:));
end
C=mod(C,2);
c=reshape(C,1,n*(L+M));
end



