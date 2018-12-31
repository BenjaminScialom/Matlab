clear all;
clc;
close all;

%% Initialisation des variables ,estimation du bruit & g?n?ration du signal bruit?


load('fcno01fz.mat');
s01 = fcno01fz;

N = 256;
N_fft = 2048;
Fs = 8000;
S = length(s01);

t = 0:1/Fs:S/Fs-(1/Fs);
t = t(:);

sigma=20;
sb01 = s01+ (sigma^2)*randn(size(s01));

% figure,
% B = length(b01);
% soundsc(b01);
% subplot(2,1,1);
% plot(t,b01);
% hold on;
% title('Signal bruite'); 
% axis([0, B/Fs, min(b01), max(b01)]);
% 
% 
% subplot(2,1,2);
% spectrogram(b01,N,250,N_fft, Fs,'yaxis');
% title('Spectrogramme signal bruite'); 
% colorbar('off');
% hold off;
%  
%% 2] Traitement de rehaussement
%f = (-1/2:1/N1:1/2-1/N1);

% Initialisation des valeurs 
fenetre=100;
d = 50;
w = hamming(fenetre);

%Fen?trage
mat1 = decomposition(sb01,w,d);
 
% Transformee de Fourier & R?cup?ration de la phase
mat2=fft(mat1).^2;

deg=angle(mat2);
phase=exp(i*deg);

% Estimation de la variance du bruit
 %--> M?thode ok mais a implemente (on connait la variance vu qu'on a
 %g?n?r? le bruit.
 
% Soustraction spectrale (on connait le bruit)
mat3=mat2-(abs(sigma))^2;
% Operations necessaires
mat4=abs(mat3).^(1/2);
S=mat4.*phase;

% Recuperation du signal debruite
signal_debruite_freq = add_recou(S,w,d);
signal_debruite= ifft(signal_debruite_freq);

% Affichage
figure,
N_fft = 2048;
N=length(signal_debruite);
t2 = 0:1/Fs:N/Fs-(1/Fs);
subplot(2,1,1);
plot(t2,signal_debruite);
title('signal debruite');
hold on,

subplot(2,1,2),
spectrogram(signal_debruite,w,d,N_fft, Fs,'yaxis');
title('Spectrogramme signal debruite');
colorbar('off');

