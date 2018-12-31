function [ Mdb, FFT, sigma ] = rehaussement2( Md, M, echantillons, sigmavrai )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% INPUT :

% Md : Matrice des trames bruitées
% M : Signal bruité
% echantillons : indice de debut et de fin du signal de base sans parole

%% OUTPUT :

% Mdb : Matrice des trames débruitées


%% Initialisation des variables
len = length(Md(1,:));
bbgc = M(echantillons(1):echantillons(2));
taille = length(bbgc);
N = 2^nextpow2(taille);
lentrame = length(Md(:,1));
% Ntrame = 2^nextpow2(lentrame);
Ntrame = 100;

 %% Estimation de sigma

% Calcul de la DSP du signal composé seulement du bbgc

DSPb = (abs((fft(bbgc, Ntrame))).^2)/(Ntrame); %DSP du bbgc
% figure(),
% plot(M);
% figure(),
% plot(bbgc),
% figure(),
% plot(M(2000:3000));
% figure(),
% plot(DSPb);
sigma = sqrt(mean(DSPb)) %sigma estimé

%% Réhaussement des trames

for k=1:len
    DSPt(:,k) = (abs(fft(Md(:,k), Ntrame)).^2)/(Ntrame);
    DSPt(:,k) = DSPt(:,k) - (sigmavrai.^2);
    phasetemp(:,k) = angle(fft(Md(:,k), Ntrame));
    for ktemp = 1:Ntrame
        if (DSPt(ktemp, k) < 0)
            DSPt(ktemp, k) = 0;
        end
    end
    FFT(:,k) = sqrt(DSPt(:,k).*Ntrame) .* exp(i*phasetemp(:,k));
    Mdb(:,k) = real(ifft(FFT(:,k), Ntrame));
end

end

