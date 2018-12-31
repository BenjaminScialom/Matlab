clear all; close all; clc ;


load('DataTestDFA.mat');

N=1000;
series=SimonRRlay(1:298,1);%série expérimentale
%series=brownNoise(N)';%bruit brun
%series=pinkNoise(N)';
%series = randn(1,N)';% bruit blanc

figure(1),
plot(fftshift(abs(fft(series))));

X=cumsum(series-mean(series));
X=transpose(X);
scale=[16, 32, 64, 128, 256]; %Ne pas dépasser la taille de la series temporelle !!
m=1;% ordre regression linéaire


%Pour chaque fenetre, calcul de la régression pour une taille de fenetre donnée
for ns=1:length(scale),
 segments(ns)=floor(length(X)/scale(ns));
 for v=1:segments(ns),
  Idx_start=((v-1)*scale(ns))+1;
  Idx_stop=v*scale(ns);
  Index{v,ns}=Idx_start:Idx_stop;
  X_Idx=X(Index{v,ns});
  C=polyfit(Index{v,ns},X(Index{v,ns}),m);
  fit{v,ns}=polyval(C,Index{v,ns});
  RMS{ns}(v)=sqrt(mean((X_Idx-fit{v,ns}).^2));
 end
 F(ns)=sqrt(mean(RMS{ns}.^2));
end


C=polyfit(log2(scale),log2(F),1);
H=C(1);
RegLine=polyval(C,log2(scale));

figure(2),
scatter(log2(scale),log2(F))
hold on
plot(log2(scale),RegLine);
