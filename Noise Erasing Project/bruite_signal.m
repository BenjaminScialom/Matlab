function [ y_r,sigma_2,nl ] = bruite_signal( y_t,Snr_10 )
%Bruité un signal de parole y
%   INPUT ARGV : y signal à bruité
%                Snr_10 bruit à ajouté
%   OUTPUT ARGV : N signal bruité

Snr=10.^(Snr_10/10);
N=length(y_t);
P1=(1/N)*sum(y_t.^2);
b1=randn(1,N);
P2=(1/N)*sum(b1.^2);
sigma_2=(P1/(P2*Snr));%%sigma_carre renvoyé 
sigma=sqrt((P1/(P2*Snr)));%%ajout de bruit %sigma_carre=P1/(P2*Snr)) en prenant la racine je retrouve sigma sans carre 
mean=0;
nl=rand(length(y_t),1).*sigma+mean;
y_r=nl+y_t;

end

