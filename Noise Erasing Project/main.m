clear all;
close all;
clc;
%% Preliminaire 1 : bruit, periodogram, correlogram 
load('fcno01fz.mat');
b=(fcno01fz)';
%% Bruit blanc de moyenne nulle et de  variance simga^2
N = 256;
N_fft = 2048;
Fs = 8000;
sigma = 4;
bruit = sigma*randn(1,N);


%% Autocorrelation
[c, t] = xcorr(bruit,[0,(length(bruit)-1)/2]);
[c1,t1]= xcorr(bruit,'biased');
[c2,t2]= xcorr(bruit,'unbiased');
subplot(2,2,1);
stem(1:length(bruit)-1,c(((length(c)-1)/2)+2:end));
title('Autocorrelation theorique');
subplot(2,2,2);
stem(1:length(bruit)-1,c1(((length(c1)-1)/2)+2:end));
title('Autocorrelation biaise');
subplot(2,2,3);
stem(1:length(bruit)-1,c2(((length(c2)-1)/2)+2:end));
title('Autocorrelation non biais??');

% f = (-1/2:1/N:1/2-1/N);
% TFb = fft(bruit);
% figure,
% plot(f,fftshift(abs(TFb)));
% title('TFD');
% 
% figure,
% plot(abs(TFb.^2)./N);
% title('Spectre de puissance');
% 
% figure,
% plot(t,fftshift(abs(fft(c./N))));
% title('DSP');
% 
% %% Bartlett method :
% L=512;
% w = hamming(L)';
% Bart1 = my_Bartlett(b,w);
% 
% figure,
% Bart2=pwelch(b,w,0);
% plot(10*log10(Bart2));
% xlim([0 L/2]);
% title('Periodogramme de Bartlett Matlab');
% 
% %% Welch method :
% 
% L=512;
% D=L/2;
% 
% w=hamming(L)';
% Welch1=my_Welch(b,w,D);
% 
% figure,
% welch2=pwelch(b,w,D);
% plot(10*log10(welch2));
% xlim([0 L/2]);
% title('Periodogramme de Welch Matlab');
% 
% %% Correlogramme
% [xc,lags] = xcorr(bruit,'coeff');
% abs_lags = 1:1:(length(lags)-1)/2;
% sig = xc(((length(lags)-1)/2)+2:end);
% stem(abs_lags,sig);
% title('correlogramme du bruit');
% 
% 
% %% Preliminaire : bruiter signal de parole
load('fcno01fz.mat');
soundsc(fcno01fz);
s01 = fcno01fz;
S = length(s01);
t = 0:1/Fs:S/Fs-(1/Fs);
t = t(:);

figure,
subplot(2,1,1);
plot(t,s01);
hold on;
title('Signal'); 
axis([0, S/Fs, min(s01), max(s01)]);


subplot(2,1,2);
spectrogram(s01,N,250,N_fft, Fs,'yaxis');
title('Spectrogramme signal'); 
colorbar('off');
hold off;

figure,
b01 = signal_bruite(s01,5); % RSB = 5/10/15
B = length(b01);
soundsc(b01);
subplot(2,1,1);
plot(t,b01);
hold on;
title('Signal bruite'); 
axis([0, B/Fs, min(b01), max(b01)]);


subplot(2,1,2);
spectrogram(b01,N,250,N_fft, Fs,'yaxis');
title('Spectrogramme signal bruite'); 
colorbar('off');
hold off;
 
%% Procedure d'addition-recouvrement

segment=100;
d = 50;
w = hamming(segment);
T = decomposition(b01,w,d);


b01_oaa = add_recou(T,w,d);
B2 = length(b01_oaa);
t2 = 0:1/Fs:B2/Fs-(1/Fs); 

figure,

subplot(2,1,1);
plot(t2,b01_oaa);
title('signal recompose');
axis([0, B2/Fs, min(b01_oaa), max(b01_oaa)]);
hold on,

subplot(2,1,2),
spectrogram(b01_oaa,w,d,N_fft, Fs,'yaxis');
title('Spectrogramme signal bruite apres recomposition');
colorbar('off');


