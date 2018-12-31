close all
clear all

N_tot=10000; 
N=[1:10];
sigma_1=2;
sigma_2=4;
JD_N=zeros(1,max(N))
JL_1_2_N=zeros(1,max(N));

signal_1=sigma_1*randn(1,N_tot);
signal_2=sigma_2*randn(1,N_tot);

Rxx_1=xcorr(signal_1,'biased');
Rxx_2=xcorr(signal_2,'biased');

for i=1:max(N)
    
    Rx_1=toeplitz(Rxx_1(N_tot: N_tot+N(i)-1));
    Rx_2=toeplitz(Rxx_2(N_tot: N_tot+N(i)-1));

    JD_N(i)=0.5*(trace((Rx_2^-1)*Rx_1+(Rx_1^-1)*Rx_2)-2*N(i))
    JL_1_2_N(i)=0.5*(trace((Rx_2^-1)*Rx_1)-N(i)-log(det(Rx_1)/det(Rx_2)));
end

figure
plot(JD_N)
title('divergence de Jeffrey en fonction de N')
ylabel('JD')
xlabel('N')
