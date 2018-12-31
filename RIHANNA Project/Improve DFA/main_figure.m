clear all, clc, close all;

%% This the main of DFA method illustration
%% Noemie Cohen && Axelle Weber

%% INPUTS
load('WEI_15.mat');
signal = randn(1,1024); % data
%signal=WEI_2_1(1:1024)';

order = 1; % order of linear regression order=[1:3]
q = 2; % mono or multi fractal q=[2:6]
overlap = 0; % windowing overlap
correction_num = 10; % if K_correction : average on <correction_number> number (1 for un-modified DFA)
AFA = 1; % if computation of AFA

%% DFA COMPUTATION
tic
[scale, F_DFA, F_DFA_corr,Signal_DFA_demo,Signal_int] = DFA_basic(signal,q,order,overlap,correction_num);
toc


%% AFA COMPUTATION
tic
if AFA == 1
[scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA] =  AFA_basic(signal,q,order);
end
toc

%% OUTPUTS : FIGURES

%% Auto-Correlation
corr = xcorr(signal,signal); %function = corr() on Matlab
figure,
subplot(1,2,1)
plot(corr);
hold on,
axis([0 length(corr) min(corr) max(corr)]);
title('Signal Autocorrelation');
xlabel('Time')
%% Spectral Analysis
N=2048;
f=(-1/2:1/N:1/2-1/N);
X = fftshift(abs(fft(signal,N)));
subplot(1,2,2)
plot(f,X);
axis([min(f) max(f) min(X) max(X) ]);
title('Signal Spectrum');
xlabel('Frequences')

%% Periodogram (v. Rolin)
%subplot(1,3,3)
%perio = periodogramme(signal,40); %step of 40 on sliding windo
%enlever la composante en 0 
%MA = filter([1 -1],1,signal);
%perio = periodogramme(MA,40); 

%% DFA
figure,
absis=(1:length(Signal_DFA_demo));
plot(Signal_int);

%% to appear the line for windows that have been cut 
% for kk=1:length(Signal)
%     if(mod(kk,102)==0)
%         test(1,kk)=300;
%     elses
%         test(1,kk)=min(Signal)-15;
%      end
% end
% hold on
% plot(test)

hold on
plot(Signal_DFA_demo)
axis([min(absis) max(absis) min(Signal_int) max(Signal_int)]);
title('Superposition of the integrated signal and the DFA treatment');
xlabel('Samples');
ylabel('Value');

% Results of DFA
Poly=reg_lin(log10(scale),log10(F_DFA),order);
Alpha=Poly(2);
RegLine=model(Poly,log10(scale),order);
figure(8),
subplot(1,2,1)
scatter(log10(scale),log10(F_DFA)); %fitting points figure
hold on
plot(log10(scale),RegLine); %linear regression figures
title('Fitting to the fluctuation function : results of DFA');
xlabel('logn');
ylabel('Fn');

%% Modified DFA
if correction_num > 1 && Alpha < 1 
  Poly2=reg_lin(log10(scale),log10(F_DFA_corr),order);
  Alpha2=Poly2(2);
  RegLine2=model(Poly2,log10(scale),order);
  subplot(1,2,2)
  scatter(log10(scale),log10(F_DFA_corr));
  hold on
  plot(log10(scale),RegLine2);
  title('DFA with correction function');
  xlabel('logn');
  ylabel('Fn');
end

%% AFA 
if AFA == 1 
  figure,
  subplot(2,1,1)
  plot(Signal_int);
  hold on
  plot(Signal_DFA_demo)
  axis([min(absis) max(absis) min(Signal_int) max(Signal_int)]);
  title('Superposition of the integrated signal and the DFA treatment ');
  xlabel('Samples')
  ylabel('Value');
  subplot(2,1,2)
  plot(Signal_int_AFA);
  hold on
  plot(Signal_AFA_demo)
  axis([min(absis) max(absis) min(Signal_int_AFA) max(Signal_int_AFA)]);
  title('Superposition of the integrated signal and the AFA treatment');
  xlabel('Samples');
  ylabel('Value');
end


