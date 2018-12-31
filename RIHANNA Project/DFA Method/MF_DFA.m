clear all; close all; clc;
load('DataTestDFA.mat');

%%Initialisation des variables

Signal=randn(1,1024)';%signal de départ

scale=[16 ,32 ,64, 128, 256, 512];
%scale=[4:10]
L=length(scale);
q=[-3,-2,-1,1,2,3];% multifractal
order=[1,2,3];%ordre pour la regression linéaire 

absis=(1:length(Signal));
recouvrement=0;


    
%%ETAPE 1 :Integrated time series
Signal=cumsum(Signal-mean(Signal));

%%Signal from beginning and from end
Signal_inv=flip(Signal);
absis_inv=flip(absis);

for mm =1:length(order)
    figure,
    
  for qq=1:length(q)
    
     Fn=zeros(1,L);
     
    %%ETAPE 2: 
    for kk=1:L
        N_trame=scale(kk);
        [Signal_cut,Absis_cut]=Decoupage_RI(Signal,absis,N_trame, recouvrement,'Rectangle');
        [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv,absis_inv,N_trame, recouvrement,'Rectangle');
        RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order(mm));
        Fn(1,kk)=(mean(RFN.^(q(qq)))).^(1/q(qq));
    end



    %%ETAPE 3 : Calcul du alpha
   
      Poly=polyfit(log10(scale),log10(Fn),order(mm));
      Alpha(order(mm))=Poly(order(mm))
      RegLine=polyval(Poly,log10(scale));
  
    scatter(log10(scale),log10(Fn))
    hold on
    plot(log10(scale),RegLine);
 
   
  end
end
 
  
