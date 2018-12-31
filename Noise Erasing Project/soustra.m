function [mat_temp_rehaussee] = soustra(mat_trames,mat_trames_bruit)

[N_trame,N_ech]=size(mat_trames);
nfft=N_ech;
mat_temp_rehaussee=zeros(N_trame,N_ech);

    for i=1:N_trame

        % Domaine fréquentiel
        signalTF=fft(mat_trames(i,:),nfft); %calcul TF du signal
        bruitTF=fft(mat_trames_bruit(i,:),nfft); %calcul TF du bruit

        %Calcul du module 
        moduleSignal=abs(signalTF); %du signal
        moduleBruit=abs(bruitTF); %du module du bruit

        %Enlèvement du bruit du signal
        nouveauModule=(moduleSignal-moduleBruit);

        %Affectation de la valeur 0 aux valeurs négatives du spectre 
        nouveauModule(nouveauModule<0)=0;

        %Nouveau signal rehaussé
        x=nouveauModule.*complex(cos(angle(signalTF)),sin(angle(signalTF)));

        %Transformée inverse  du signal pour repasser au domaine temporel
        mat_temp_rehaussee(i,:)=real(ifft(x));

    end
end
