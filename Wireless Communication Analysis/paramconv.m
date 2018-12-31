
% J.Kern & B.Scialom T2
% TP codes convolutifs

function [G,M,T] = paramconv(g)
% g : vectors with entries in octal representing the polynomial generators of a dimension 1 convolutional code. 
% G : binary matrix whose rows contains the coefficients of each polynomial generator specified in g, from lowest to highest degree. 
% M : memory of the convolutional code specified by the generator polynomials in g.
n=length(g); % Length of the code
for i=1:n
    gtmp(i) = base2dec(int2str(g(i)),8); % from octal to binary
end
G = dec2bin(gtmp)-'0';
G=fliplr(G);
for i=1:n
   if(g(i)==1) % Nous faisons un test dans le cas o? le vecteur 1 est choisi car sinon cela provoque une inversion lors de l'impl?mentation qu'il faut anticiper.
       G=fliplr(G);% S'il y a bien le vecteur g?n?rateur 1, nous effectuons l'inversion.
   end
end

M=length(G(1,:))-1; %On d?finit la taille de la m?moire.
T=-1*ones(2^M);% initialisation de la matrice T.
for i=0:2^M-1
    for j=0:1
        m=[de2bi(i,M) j]; %[m_t-M m_t-M+1 ... m_t]
            
       for k=1:size(G,1)
          c(k)= mod(G(k,:)*m',2); %calcule de c
       end
       T(i+1,bi2de(m(2:length(m)))+1)=bi2de(c,'left-msb'); %Remplissage de la matrice T   
    end
end
end