function [ h2,ai_est,var_est ] = ar_estimation( signal,ordre )
%% Estimating the ai coefficients associated to the AR model
%   The outputs are the estimated filter function and the ai parameters

N = length(signal);
f = -1/2:1/N:1/2-1/N;

[Rxx_est,t] = xcorr(signal,'biased'); %we take the biased autocorrelation estimator
% of the signal created previously (filtered white noise)

R = toeplitz(Rxx_est(N:N+ordre-1)); %we create a Toeplitz matrix containing the various
%values of the autocorrelation.

A = -inv(R)*Rxx_est(N+1:N+ordre); %A contains the values of the ai corresponding to the
%estimated filter function

A =[1 A.'];
h2 = freqz(1,A,2*pi*f);
ai_est = A.';
var_est = abs(A*Rxx_est(N:N+ordre));


end

