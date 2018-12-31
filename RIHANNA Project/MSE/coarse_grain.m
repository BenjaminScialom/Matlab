%ne pas prendre en consideration les commentaires

%%taille
%rem pour reste de la division euclidienne et floor(a/b) pou le quotient
%ainsi on sera sur que la taille est divisible par la scale
%Prepartion du signal et crétaion des variables necessaire
%ajout de copyright 


function [cg_signal,original_signal_adapted]=coarse_grain(original_signal,scale)
%cette fonction renvoie, pour un signal d'origine(invariant) et un scale, le signalen grain-crossier correspondant 
% original_signal=;
l=length(original_signal);
% scale=;
a=rem(length(original_signal),scale);
%original_signal_adapted est le signal sur lequel seront fait les calculs,invariant
%cg_signal est le signal en grain-crossier obtenu 


%ajout condition sur longueur signal par rapport a lechelle 
if a==0
   original_signal_adapted=original_signal;
   cg_signal=zeros(1,floor(l/scale));
else
    original_signal_adapted=original_signal(1:floor(l/scale)*scale);
    cg_signal=zeros(1,floor(l/scale));
end

%%remplissage de cg

for j=1:length(cg_signal)
    for i= (j-1)*scale+1: j*scale
        cg_signal(j)=cg_signal(j)+original_signal_adapted(i);
    end
    cg_signal(j)=cg_signal(j)/scale;
end

%%coté esthetique ' = ' , nom fonction ...





end

    
    


