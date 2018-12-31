

%Copyright (C) 2018, B. Youssef
%Email: ybelyazid@enseirb-matmeca.fr
%Rihanna Project

%---------------------------------------------------------------------------------


%This script calculates the estimated and theroretical cross-entropy between 
%two zero-mean white gaussian noises


%---------------------------------------------------------------------------------

close all

N_tot=10000;                      %Number of samples
Vect_N=[1:20];                    %Dimension vector
sigma_1=2;                        %Standard deviation of zero-mean WGN 1
sigma_2=4;                        %Standard deviation of zero-mean WGN 2
CE_N=zeros(1,length(Vect_N));     %Estimated cross-Entropy vector 
theory=zeros(1,length(Vect_N));   %Theoretical cross-entropy vector
samples=[1:N_tot];                %Vector indexing the number of samples  

%generation of the signals
signal_1=sigma_1*randn(1,N_tot);
signal_2=sigma_2*randn(1,N_tot);

%computing of estimated autocorrelation function
Rxx_1=xcorr(signal_1,'unbiased');
Rxx_2=xcorr(signal_2,'unbiased');

%building the autocorrelation matrix and calculating the estimated cross-entropy 
for i=1:max(Vect_N)
    
    Rx_1=toeplitz(Rxx_1(N_tot: N_tot+Vect_N(i)-1));
    Rx_2=toeplitz(Rxx_2(N_tot: N_tot+Vect_N(i)-1));

    CE_N(i)=0.5*(trace((Rx_2^-1)*Rx_1)-log(det(Rx_1)/det(Rx_2)))+Vect_N(i)*log(sqrt(2*pi)*det(Rx_1));
   
end


%comparison of the estimated and theoretical cross-entropy between two zero-mean WGN
theory=0.5*(Vect_N*(sigma_1^2/sigma_2^2)-2*Vect_N*log(sigma_1/sigma_2))+Vect_N*log(sqrt(2*pi))+2*(Vect_N.^2)*sigma_1;
figure
plot(Vect_N,theory,'red');
hold on
plot(Vect_N,CE_N,'blue');
ylabel 'Cross-Entopy'
xlabel 'N'
title (' Cross-entropy between two zero mean WGN')
legend('theoretical','estimated')
hold off

%Comparison of the estimated and theoretical first derivative of the cross-entropy between two zero mean WGN
figure
plot(Vect_N(1:length(Vect_N)-1),diff(theory)./diff(Vect_N),'red');
hold on
plot(Vect_N(1:length(Vect_N)-1),diff(CE_N)./diff(Vect_N),'blue');
ylabel 'Derivative of the cross-entropy')
xlabel 'N'
title (' Derivative of the cross-entropy between two zero mean WGN')
legend('theoretical','estimated')
hold off

%Comparison of the estimated and theoretical second derivative of the cross-entropy between two zero mean WGN
figure
plot(Vect_N(1:length(Vect_N)-2),diff(diff(theory)),'red');
hold on
plot(Vect_N(1:length(Vect_N)-2),diff(diff(CE_N)),'blue');
ylabel 'Second derivative of the cross-entropy')
xlabel 'N'
title ('Second derivative of the cross-entropy between two zero mean WGN')
legend('theoretical','estimated')
hold off
