function [ M] = Rehaussement(D,echantillons,recouvrement,x_absis,fenetre )
%Bruité un signal de parole y
%   INPUT ARGV : D matrice au signal découpé
%                 echantillons ou que le bruit
%   OUTPUT ARGV : M matrice réhaussé


%%Initialisation des variables 
[N_e,N_trame]=size(D);
Nfft=N_trame;
M=zeros(N_e,N_trame);
%%Determination de la DSP du signal bruité
DSP_BBGC=abs(fft(echantillons,Nfft)).^2;
sigma=sqrt(mean(DSP_BBGC));

%%Determination de la DSP sur chaque trame       
for i=1:N_e
        % Domaine fréquentiel
        DSP_D=abs(fft(D(i,:),Nfft)).^2; %calcul TF du signal
        phase_ajout=angle(fft(D(i,:),Nfft));
        %Enlèvement du bruit du signal
        DSP_D=(DSP_D-((sigma).^2));
        %Affectation de la valeur 0 aux valeurs négatives du spectre 
        DSP_D(DSP_D<0)=0;
        %Nouveau signal rehaussé
        M_R=sqrt(DSP_D).*exp(j*phase_ajout);
        %Transformée inverse  du signal pour repasser au domaine temporel
        M(i,:)=real(ifft(M_R,Nfft));

end

end

