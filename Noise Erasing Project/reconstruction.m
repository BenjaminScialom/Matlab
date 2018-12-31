function [ signal ] = reconstruction(M,recouvrement,fenetre)


%%%%%%%%INPUTS :
%%%%%%%%%%%%%%%% - recouvrement: pourcentage (minimal) sera ecrit : ex 10% --> 0.1
%%%%%%%%%%%%%%%%- Matrice dont les LIGNES sont les differentes trames
%%%%%%%%OUTPUTS : 
%%%%%%%%%%%%%%%% - signal d'origine


[N_e,N_trame]=size(M)
N_rec=ceil(N_trame*recouvrement)
N_inde=N_trame-N_rec

N_s=(N_e-1)*N_inde+N_trame

signal=zeros(N_s,1);

if(fenetre=='Hamming')
    window=hamming(N_trame)
    
elseif (fenetre=='Rectangle')
    window=ones(N_trame,1)
end

signal_num=zeros(N_s,1);
signal_denum=zeros(N_s,1);

debut=0;

for ligne=1:N_e
    for i=1:N_trame
        signal_num(debut+i,1)=signal_num(debut+i,1)+M(ligne,i);
        
        
        signal_denum(debut+i,1)=signal_denum(debut+i,1)+window(i);
    end
    debut=debut+N_inde;
end
signal=signal_num./signal_denum;
end

