clc;                % Effacement de la page de resultat Matlab
clear all;          % Elimination de l'espace memoire Matlab de toutes les variables precedemment calculees
close all;          % Fermeture de toutes les fenetres graphiques
fig=1;              % Indice de la figure courante
Fe=40000;           % Definition de la frequence d'echantillonnage
Te=1/Fe;            % Periode d'echanillonnage Te=1/Fe

%*************************************************************
% Allures temporelles et frequentielles des fenetres
%*************************************************************
N=100;                      % Nombre d'echantillons de la fenetre
Nfft = 1024;                % Nombre de points de calcul des differentes FFT
y=zeros(4,N);               % Matrice contenant les differentes fenetres dans le domaine temporel
y_f=zeros(4,Nfft);          % Matrice contenant les differentes fenetres dans le domaine frequentiel

%=============================================================
% Fen???tres dans le domaine temporel
y(1,:)= boxcar(N)';         % Fenetre rectangulaire
y(2,:)= hanning(N)';        % Fenetre de Hanning
y(3,:)= hamming(N)';        % Fenetre de Hamming
y(4,:)= blackman(N)';       % Fen???tre de Blackman
%=============================================================
% Fenetres dans le domaine frequentiel
for k=1:4
    y_f(k,:)= fftshift(abs(fft(y(k,:),Nfft)));
end
%=============================================================
% Trace des fenetres dans le domaine temporel
figure(fig)
plot(y(1,:),'b');
hold on
plot(y(2,:),'g');
plot(y(3,:),'r');
plot(y(4,:),'m');
grid
legend('Rectangulaire', 'Hanning', 'Hamming', 'Blackman'),
title('Fenetres temporelles')
xlabel('Echantillons temporels')
ylabel('Amplitude du signal');
fig=fig+1;
%=============================================================
% Tracer des fenetres dans le domaine frequentiel, echelle lineaire
freq=linspace(0,Fe,Nfft+1);
freq=freq(1:end-1);
freq=freq-Fe/2;
figure(fig)
plot(freq, y_f(1,:),'b');
hold on
plot(freq, y_f(2,:),'g');
plot(freq, y_f(3,:),'r');
plot(freq, y_f(4,:),'m');
grid
legend('Rectangulaire', 'Hanning', 'Hamming', 'Blackman'),
title('Spectre des fenetres en echelle lineaire')
xlabel('Frequence en Hz')
ylabel('Module de la TF');
fig=fig+1;
legend('rectangulaire', 'Hanning', 'Hamming', 'Blackman'),
%=============================================================
% Trace des fenetres dans le domaine frequentiel, echelle logarithmique
figure(fig)
semilogy(freq, y_f(1,:),'b');
hold on
semilogy(freq, y_f(2,:),'g');
semilogy(freq, y_f(3,:),'r');
semilogy(freq, y_f(4,:),'m');
grid
legend('Rectangulaire', 'Hanning', 'Hamming', 'Blackman'),
title('Spectre des fenetres en echelle logarithmique')
xlabel('Frequence en Hz')
ylabel('Module de la TF');
fig=fig+1;