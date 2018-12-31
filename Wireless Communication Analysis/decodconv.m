function [ m ] = decodconv(y, g)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Initialisation des variables et des matrices.
n=length(g);
[G,M, T] = paramconv(g);
L=(length(y)/n)-M;
W = -1*ones((2^M),(L+M+1));
S = -1*ones((2^M),(L+M+1));

%"Convention" pour le premier ?tat dans les matrices S et W.
W(1,1)=0;
S(1,1)=1;

%Mise en place du Treillis
for i=2:(L+M+1)
   for j=1:2^M 
       
       if(W(j,i-1)>-1)% Cas des chemins montant (convention traits pointill?s)
         l= ceil(j/2);
         x = W(j,i-1) + sqrt(sum((de2bi(T(j,l),'left-msb',n)- y(1+(i-2)*n:n+(i-2)*n)).^2));%sum(mod(de2bi(T(j,l),'left-msb',n)+y(1+(i-2)*n:n+(i-2)*n),2));
         if(W(l,i)==-1 || W(l,i)>x)
            W(l,i) = x;
            S(l,i) = j;
         end
         
         if(i<L+2)% Cas des chemins desendant (convention traits pleins)
            l= ceil(j/2)+2^(M-1); 
            x = W(j,i-1) + sqrt(sum((de2bi(T(j,l),'left-msb',n)- y(1+(i-2)*n:n+(i-2)*n)).^2));% + sum(mod(de2bi(T(j,l),'left-msb',n)+y(1+(i-2)*n:(i-1)*n),2));
            if(W(l,i)==-1 || W(l,i)>x)
                W(l,i) = x;
                S(l,i) = j;
            end
         end
       end
   end
end

%D?termination du message d?cod? en r?cup?rant le chemain ayant les poids
%cumul?s les plus faibles.
x=S(1,L+M+1);

for i=L+M-1:-1:1 %On parcourt la matrice S ? l'envers afin de s?lectionner le bon chemain.
    y = S(x,i+1);% y correspond ? la valeur de l'?tat suivant ? celui dans lequel est x.
    
    if(x==1 && y==1)
       m(i)=0; 
    elseif(x==2^M && y==2^M)
        m(i)=1;
    elseif(x<y)
        m(i)=0;
    else
        m(i)=1;
    end
        
    x = y;
    
end

m=m(1:L);%On retire les valeurs attribu? et correspondant ? des ?tats sup?rieur ? n=L.

end
