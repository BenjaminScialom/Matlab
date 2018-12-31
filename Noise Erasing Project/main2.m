%% Main débruitage de trames

%% Initialisation des variables

clear all, close all, clc,

load('fcno01fz.mat');
Fe = 8 * 10^3; % Fréquence d'échantillonnage
taille = length(fcno01fz);
x = fcno01fz(1:taille); % Renommage de l'échantillon
recouvrement = 0; % Recouvrement d'une trame en %
N = 256; % Longueur d'une trame (puissance de 2)
RSBdB = [5, 10, 15]; % Tableau arbitraire de RSBdB
mu = 0; % Moyenne du bruit
fenetre = ones(1, N); % Fenetrage choisi
echantillons = [24000 25000];


%% Creation de la bibliothèque de signaux bruités

[M, sigma] = bruitage(x, Fe, RSBdB, mu, fenetre); % M matrice des x bruitées
% figure(),
% plot(M(1,:));
% figure(),
% plot(M(2,:));
% figure(),
% plot(M(3,:));


%% Découpage d'un signal bruité en trame (avec fenêtre particulière)

for k=1:length(M(:,1))
    [Md(:,:,k)] = decomp(M(k,:), N, recouvrement);
end


%% Réhaussement des trames

for k=1:length(M(:,1))
    [Mdb(:,:,k), phase, sigma(k)] = rehaussement(Md(:,:,k), M(k,:), echantillons, sigma);
end

%% Reconstruction du signal via les trames débruitées

for k=1:length(M(:,1))
    [L(k,:), mask] = recomp(Mdb(:,:,k), recouvrement, fenetre, taille);
end

figure(),
subplot(2,1,1),
plot(M(1,:));
subplot(2,1,2),
plot(L(1,:));
figure(),
subplot(2,1,1),
plot(M(2,:));
subplot(2,1,2),
plot(L(2,:));
figure(),
subplot(2,1,1),
plot(M(3,:));
subplot(2,1,2),
plot(L(3,:));


%% Analyse des performances de notre débruitage

for k=1:length(M(:,1))
    err(k) = 0;
    err(k) = sum(abs(L(k,1:end-1000)-M(k,1:end-1000)))/(length(L(1,:))-1000);
end

figure(),
plot(RSBdB, err);
Ps = sum(x(1:end-1000).^2);
for k=1:length(M(:,1))
    Pb(k) = sum(L(k,1:end-1000).^2);
    RSBestime(k) = 10^(Ps./(Pb(k)));
end
