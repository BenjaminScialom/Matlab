clear all;
clc;
close all;

%% Initialisation des variables ,estimation du bruit 

load('fcno01fz.mat');
load('fcno04fz.mat')
s01 = fcno01fz;
s04 = fcno04fz
soundsc(s01);

N = 256;
N_fft = 2048;
Fs = 8000;
%S = length(s01);
S = length(s04);


t = 0:1/Fs:S/Fs-(1/Fs);
t = t(:);


%% Generation du signal bruite
sigma=20;

%bruit = (sigma^2)*randn(size(s01));
bruit = (sigma^2)*randn(size(s04));
%bruit2 = signal_bruite(s01,15);
b04 = s04 + bruit
%B = length(b01);
B2 =length(b04);

%% Signal originel
figure,
subplot(2,1,1);
%plot(t,s01);
plot(t,s04);
title('Signal originel');
%axis([0, B/Fs, min(s01), max(s01)]);
axis([0, B2/Fs, min(s04), max(s04)]);
%Spectre signal originel
TFs = fft(s01);
%TFs=fft(s04);
%f = (-1/2:1/B:1/2-1/B);
f=(-1/2:1/B2:1/2-1/B2);
subplot(2,1,2);
%spectrogram(s01,N,250,N_fft, Fs,'yaxis');
spectrogram(s04,N,250,N_fft,Fs,'yaxis');
colorbar('off');
title('Spectrogramme signal originel');
hold off;

%% signal bruite
figure,
subplot(2,1,1);
%plot(t,b01);
plot(t,b04);
title('Signal bruite'); 
%axis([0, B/Fs, min(b01), max(b01)]);
axis([0, B2/Fs, min(b04), max(b04)]);

%spectre signal bruite
%TFb = fft(b01);
TFb = fft(b04);
%subplot(2,3,5);
%plot(f,fftshift(abs(TFb)));
%title('Spectre Signal bruite');
subplot(2,1,2);
%spectrogram(b01,N,250,N_fft,Fs,'yaxis');
spectrogram(b04,N,250,N_fft,Fs,'yaxis');
colorbar('off');
title('Spectrogramme signal bruite');
hold off;

%fenetre=100;
d = 0.5;
%w = hamming(fenetre);

%%  Decomposition en trames

xabsis=[0 :1/Fs: length(fcno04fz)/Fs-1/Fs];
%xabsis=[0 :1/Fs: length(fcno01fz)/Fs-1/Fs];
%xabsis2=[0 :1/Fs: length(b01)/Fs-1/Fs];
xabsis2=[0 :1/Fs: length(b04)/Fs-1/Fs];
xabsis3=[0 :1/Fs: length(s04)/Fs-1/Fs];
%xabsis3=[0 :1/Fs: length(s01)/Fs-1/Fs];

% A = decomposition(b01,w,d);
% A_bis = decomposition(s01,w,d);
A = decoupage(b04,xabsis2,100,d,'Hamming');
A_bis = decoupage(s04,xabsis3,100,d,'Hamming');


%echantillons = b01(24000 :25000);
echantillons = b04(1 :1000);

[ D_s, A_s ]  = decoupage(b04,xabsis,100,d,'Hamming');
%[ D_s, A_s ]  = decoupage(b04,xabsis,100,d,'Hamming');
M = Rehaussement(D_s,echantillons,d,xabsis,'Hamming');
signal_debruite = reconstruction(M,d,'Hamming');

%% D?composition par trames - signal originel et bruite
t2 = 0:1/Fs:100/Fs-(1/Fs);
t2 = t2(:);
figure, 
% plot(t2,A_bis(:,1));

%signal original
plot(t2,A_bis(800,:),'r');

hold on, 
% plot(t2,A(:,1));

%signal bruite
plot(t2,A(800,:),'g');


plot(t2,M(800,:),'b');

title('Representation temporelle d''une trame')
hold off,
legend({'Signal original','signal bruite','signal rehaussee'},'bold');


%% Appliquation m?thode de soustraction spectrale
% % Spectre de puissance du signal bruite
% 
%  TFsb = fft(A);
% 
%  SPsb = abs(TFsb.^2)./S;t2
% 
%  
%  % Estimation DSP bruit : DSP/Corr??logramme/variance
% 
%  Rb=xcorr(bruit(1:100)); % Remplacer par xcorr sous matlab / corr sous otave
% 
%  DSP = abs(fft(Rb./S));
%  y = DSP(1:100);
%  
%  % Module du signal de parole buit?? dans le domaine fr??quentiel
%  S = repmat(sigma,size(TFsb));
%  M = SPsb-S; 
%  M = (M>0).*M;
% %  M = M.*TFsb./abs(TFsb);
%  
%  % Phase dans le domaine fr??quentiel
%  P = TFsb;
%  deg = angle(P);
%  phase = exp(1i*deg);
%  
% 
%  
%  % puis dans le domaine temporel
% B = ifft(sqrt(M).*phase);
% signal_debruite = add_recou(B,w,d);

%% D?composition par trames - signal r?hauss?e
% plot(M(:,1));
% title('Repr?sentation temporelle d''une trame de parole r?hauss?e');
%  hold off,
%  legend('Signal original','signal bruite','signal r?hauss?e');
% 

%% Signal debruite



%  axis([0, length(signal_debruite)/8000, min(signal_debruite), max(signal_debruite)]);
% axis([0,length(signal_debruite),min(signal_debruite), max(signal_debruite)]);
% Calculer le RSB sur signal bruite et signal r??hauss??; comparez
% RSB_bruite= 10*log(sum(b01.^2)/sum(bruit.^2));
% RSB_bruite= 10*log(sum(signal_debruite.^2)/sum(bruit.^2));

 %% Repr?sentation du spectre en amplitude
 
 figure, 

 
 subplot(3,1,1);
 plot(-Fs/2:Fs/100:Fs/2-(Fs/100),abs(fftshift(fft(A_bis(800,:)))),'r');
 title('Spectre d''amplitude pour une trame')
 subplot(3,1,2);
 plot(-Fs/2:Fs/100:Fs/2-(Fs/100),abs(fftshift(fft(A(800,:)))),'g');
 
 subplot(3,1,3);
 plot(-Fs/2:Fs/100:Fs/2-(Fs/100),abs(fftshift(fft(M(800,:)))),'b');
 
%% Signal debruite
figure,
subplot(2,1,1);
N_fft = 2048;
N=length(signal_debruite);
t2 = 0:1/Fs:N/Fs-(1/Fs);
plot(t2,signal_debruite);
title('signal debruite');
hold on,

% Spectrogramme signal debruite
subplot(2,1,2);
spectrogram(signal_debruite,100,0,N_fft, Fs,'yaxis');
colorbar('off');
title('Spectrogramme Signal debruite');
hold off;
 