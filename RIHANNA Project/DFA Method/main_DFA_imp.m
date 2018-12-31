clear all; close all; clc;
load('DataTestDFA.mat');

%%Initialisation des variables
Signal=(SimonRRstand(1:297,1))';%signal de départ
Signal=SimonRRsit';

%scale=[16 ,32 ,64, 128, 256 ];
scale=[4:10];
L=length(scale);
Fn=zeros(1,L);
absis=(1:length(Signal));
order=1;%ordre pour la regression linéaire 
recouvrement=0;
%%ETAPE 1 : ENLEVER MOYENNE
Signal=cumsum(Signal-mean(Signal));
Signal_inv=flip(Signal);
absis_inv=flip(absis);
%%ETAPE 2: 
for kk=1:L
    N_trame=scale(kk);
    [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N_trame, recouvrement,'Rectangle');
    [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame, recouvrement,'Rectangle');
    RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
    Fn(1,kk)=sqrt(mean(RFN.^2));
end

Poly=polyfit(log10(scale),log10(Fn),1);
Alpha=Poly(1)
RegLine=polyval(Poly,log10(scale));

figure(2),
scatter(log10(scale),log10(Fn))
hold on
plot(log10(scale),RegLine);
