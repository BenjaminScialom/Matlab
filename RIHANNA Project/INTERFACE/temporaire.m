%% Explanation


% In this MatLab script, we will test all the functions linked to the 
% power analysis. Firstly, we will create a white gaussian noise that we
% will later filter through a IIR filter with defined poles. We will then
% apply our two methods : FFT+zero padding and AR coefficients estimation
% before comparing the rectangular and trapezoid methods applied to both
% methods.


%% BBG

var = 1;
mu = 0;
N = 3000;
bbg = randn(1,N)*sqrt(var)+mu;



 %% Filtering
poles = 0.8*exp(1i*2*pi*[-1/2 -1/4 0 1/4]); % roots of the unity as poles
ai_true=poly(poles);

x = filter(1,ai_true,bbg).'; % synthetic signal 
%x = abs(x);
%x = bbg;
%% FFT method

% x = SimonRR;
% N = length(x);

f = -1/2:1/N:1/2-1/N;

%% Zero Padding
padding = input('Valeur du padding ? '); % we set the zero padding
Power_Spectrum = (abs(fftshift(fft(x,N+padding))).^2)/N ;

f2 = -1/2 : 1/(N+padding) : 1/2-1/(N+padding);

%% Spectral power density

pas_periodo = input('taille de la fenetre glissante ? '); % the width of the sliding window of the periodogram

periodo = periodogramme_2(Power_Spectrum,pas_periodo);

%DSP_est = TF_F;

figure(3)
plot(f2,Power_Spectrum,'Color',[0.5,0.25,0.5])
hold on;
plot(f2,area(f2,periodo))
title('Estimation of the spectral density of our signal')
legend('Power Spectrum','Estimated PSD')
xlabel('normalized frequencies')
ylabel('amplitude')
hold off;

%% Values (future input)

fmin = input('Value of fmin ? ');

while fmin < 0 || fmin > N
    disp('Erreur : fmin non inclus dans la gamme de frequences')
    fmin = input('valeur de fmin ? (comprise dans la gamme de frequences...) ');
end

fmax = input('Value of fmax ? ');

while fmax < 0 || fmax > N
    disp('Erreur : fmax non inclus dans la gamme de frequences')
    fmin = input('valeur de fmax ? (comprise dans la gamme de frequences...) ');
end

if fmin > fmax
    fmin,fmax = fmax,fmin
end

pas_puissance = input('taille du pas des methodes des rectangles et trapezes ? ');

%% Rectangular method

[P_rectangle,X,Y] = methode_rectangle(periodo,pas_puissance,fmin+padding/2,fmax+padding/2);

% periodo remplacable par une entree au choix 

X = X/(N+padding) - 1/2;

figure(4)
subplot(1,2,1)
plot(f2,periodo,'red')
title('Rectangular method applied to the periodogram')
hold on
plot(f2,area(X,Y))
legend('Periodogram','area between fmin and fmax')
xlabel('normalized frequencies')
ylabel('amplitude')
hold off

%% Trapezoid method

[P_trapeze, X_TPZ, Y_TPZ] = methode_trapeze(periodo,pas_puissance,fmin+padding/2,fmax+padding/2);

% le choix de l'entree est laisse a l'utilisateur

X_TPZ = X_TPZ/(N+padding) - 1/2;

figure(4)
subplot(1,2,2)
plot(f2,periodo,'red')
title('Trapezoid method applied to the periodogram')
hold on
plot(f2,area(X_TPZ,Y_TPZ))
legend('Periodogram','area between fmin and fmax')
xlabel('normalized frequencies')
ylabel('amplitude')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SECOND METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% AR model

% We now create a signal by filtering our white noise with an AR filter

%% Theoretical filter
poles = 0.8*exp(1i*2*pi*[-1/2 -1/4 0 1/4]); %cubic roots of the unity as poles
ai_true=poly(poles);

% The following line is commented as we already filtered our white noise

%x = filter(1,ai_true,bbg); %filtering the white noise to obtain our signal

h = freqz(1,ai_true,2*pi*f); %obtaning the filter function and plotting the fft 
%to make sure the poles are at the right place

% figure(5)
% %subplot(2,1,1)
% plot(f,abs(h).^2*var); %plotting the synthetic filter's spectrum
% hold on;

%% Estimation autocorrelation

%p = length(poles);
% this line is only relevant if we want to set the order of the AR method
% according to the filter we generated. In the case of our program, this
% step will be quite irrelevant as we have no information on the supposed
% filter at the origin of our signal.

Var = [];
p = [];

limit_p = input('limite ordre p ? ')
for i=1:1:limit_p
    [h2,ai_est,var_est] = ar_estimation(x,i);
    Var = [Var var_est];
    p = [p i];
end

figure(8)
plot(p,Var)
title('Variance as a function of the filter order p')
xlabel('Filter order')
ylabel('Variance')

filter_order = input('Order of the filter ? ');

[h2,ai_est,var_est] = ar_estimation(x,filter_order);

% figure(5)
% %subplot(2,1,1)
% plot(f,abs(h2).^2*var_est);
% legend('Estimated PSD')
% hold on;

% figure(5)
% subplot(2,1,2)
% zplane(ai_true)
% hold on
% zplane(ai_est)
%hold off

periodo_ar = periodogramme_2(abs(h2).^2*var_est,pas_periodo);

figure(6)
semilogy(f,fftshift(abs(fft(x)).^2)/N,'Color',[0.5,0.25,0.5])
hold on;
semilogy(f,periodo_ar,'red')
legend('Estimated PSD','Periodogram')
title('Comparition between the estimated PSD and periodogram')
xlabel('normalized frequencies')
ylabel('log(amplitude)')
hold off;


%% Rectangular method

[P_rectangle,X2,Y2] = methode_rectangle(periodo_ar,pas_puissance,fmin,fmax);
X2 = X2/N - 1/2;

figure(7)
subplot(1,2,1)
semilogy(f,periodo_ar,'red')
title('Rectangular method applied to the periodogram')
hold on
semilogy(f,area(X2,Y2))
legend('Periodogram','area between fmin and fmax')
xlabel('normalized frequencies')
ylabel('log(amplitude)')
hold off

%% Trapezoid method

[P_trapeze, X_TPZ2, Y_TPZ2] = methode_trapeze(periodo_ar,pas_puissance,fmin,fmax);
X_TPZ2 = X_TPZ2/N - 1/2;

figure(7)
subplot(1,2,2)
semilogy(f,periodo_ar,'red')
title('Trapezoid method applied to the periodogram')
hold on
semilogy(f,area(X_TPZ2,Y_TPZ2))
legend('Periodogram','area between fmin and fmax')
xlabel('normalized frequencies')
ylabel('log(amplitude)')
hold off