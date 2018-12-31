% This code is written by PAUVERT Simon and SCIALOM Benjamin

clearvars -except database; % This line replaces the usual "clear"
% Resets matlab workspace except database

close all; % Closes every open figure
clc;       % Clears the command window

%% Load database

if ~exist('database','var')
    load('database'); %Loads database
end

%% Initialisation of dome project constants

N_DB_FILES = size(database,2); % The number of files in the database

%% Start of your processing

% sound(database{10}.Samples,database{10}.Fs); % Plays the sample 12
% tic
% % Task 1 :
% 
Fs = database{12}.Fs;
x = database{12}.Samples;

% tfix = 1:1/Fs:4-1/Fs;
% echx = x(Fs:Fs+size(tfix,2)-1);
% 
% plot(tfix,echx);
% 
% % Task 2 :
% 
% [xaxis,yaxis] = ginput();
% 
% hold on
% for k=1:size(xaxis,1)
%     
%     t=xaxis(k,:):1/Fs:xaxis(k+1,:)-1/Fs;
%     echx = x(xaxis(k,:)*Fs:xaxis(k+1,:)*Fs-1);
%     plot(t,echx,'color',rand(1,3))
% end

%% Task 3 :


Nfft = 2048;
F = -Fs/2:Fs/Nfft:Fs/2-1/Nfft;

% N1=0.1*Fs;
% S1=0.5*Fs;
% t1= S1/Fs:1/Fs:(N1+S1-1)/Fs;
% echx1 = x(Fs:Fs+size(t1,2)-1);
% DFT1=fftshift(abs(fft(echx1,Nfft)));
% subplot(3,1,1)
% plot(F,DFT1,'-b');
% 
% 
% N2=0.01*Fs;
% S2=0.5*Fs;
% t2= S2/Fs:1/Fs:(N2+S2-1)/Fs;
% echx2 = x(Fs:Fs+size(t2,2)-1);
% DFT2=fftshift(abs(fft(echx2,Nfft)));
% subplot(3,1,2)
% plot(F,DFT2,'-r');


% N3=0.1*Fs;
% S3=0.5*Fs;
% t3= S3/Fs:1/Fs:(N3+S3-1)/Fs;
% echx3 = x(Fs:Fs+size(t3,2)-1);
% sh = echx3.*hamming(floor(N3))';
% DFT3=fftshift(abs(fft(sh,Nfft)));
% subplot(3,1,3)
% plot(F,DFT3,'-g')
y=x(1:4*Fs);
N_fft=2048;
% [~,~,~]=stft(y,hamming(1102),55,2048,Fs);
% S=spectro(X);
% imagesc(t,f,log(S));
% 
%% TASK 4-5-6 :

% d1=floor(0.05*Fs);
% w1=ones(floor(N1),1);
% [X1,f1,t1] = stft(y,w1,d1,N_fft,Fs);
% S=spectro(X1);
% subplot(3,1,1)
% imagesc(t1,f1,log(S));
% 
% d2=fix(0.005*Fs);
% w2=ones(floor(N2),1);
% [X2,f2,t2] = stft(y,w2,d2,N_fft,Fs);
% S=spectro(X2);
% subplot(3,1,2)
% imagesc(t2,f2,log(S));
% 
% d3=fix(0.05*Fs);
% w3=hamming(floor(N3));
% [X3,f3,t3] = stft(y,w3,d3,N_fft,Fs);
% S=spectro(X3);
% subplot(3,1,3)
% imagesc(t3,f3,log(S));
[X,f,t]=stft(y,hamming(1102),55,2048,Fs);
[x]=istft(X,hamming(1102),55,2048,Fs);
plot(x,'-b')
hold on
plot(y,'-r')

% toc