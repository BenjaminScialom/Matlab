function [ D_s, A_s ] = Decoupage_RI(  signal,xabsis,N_trame, recouvrement,fenetre)

%%%%%%%%INPUTS :
%%%%%%%%%%%%%%%% - recouvrement: pourcentage (minimal) sera ecrit : ex 10% --> 0.1
%%%%%%%%%%%%%%%% - signal
%%%%%%%%%%%%%%%% - N_trame : taille des trames qui seront trait�es en
%%%%%%%%%%%%%%%% nb d'echantillons 
%%%%%%%%OUTPUTS : 
%%%%%%%%%%%%%%%% - Matrice dont les LIGNES sont les differentes trames
%%%%%%%%%%%%%%%% - Abscisse dont les lignes sont


%N_S longueur du signal en nb d'echantillons
N_s=length(signal);


%partie commune aux trames adjacente en nombre d'�chantillons
N_rec=ceil(N_trame*recouvrement);

%nb d'echantillons independant par trame
N_inde=N_trame-N_rec;

%Nombre de trame cr�es avec ce decoupage
N_e=floor((N_s-N_rec)/(N_trame-N_rec));

%La matrice de Sortie initialis�e � (0)
D_s=zeros(N_e,N_trame);
A_s=zeros(N_e,N_trame);
debut=1;
fin=N_trame;

%if(fenetre=='Hamming')
%     window=hamming(N_trame)
%     
% elseif (fenetre=='Rectangle')
%     window=ones(N_trame,1)
% end               
    
for k=1:N_e
    D_s(k,:)=signal((debut):(fin),1);%.*window;
    A_s(k,:)=xabsis(1,(debut):(fin));
    debut=debut+N_inde;
    fin=fin+N_inde;
end

end
