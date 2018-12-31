function [ x ] = istft( X,w,d,N_fft,Fs )
% This function computes the istft from a stft matrix
% INPUT
% X, wich is a matrix of n_fft lines and P columns
% P is the number of windows
% w, is the window
% d, is the shift between two successive windows
% Nfft is the size of ffts
% Fs is the sampling rate
% 
% OUTPUT
% 
% x, the signal as a function of t
% t, is a row vector containing sampling times
N = numel(w);
P = size(X,2);
xt = zeros(N_fft,P);
W0 = sum(w);
x = zeros(1,P*d);

xt = ifft(X,N_fft);

for n = 1:P*d
    for p = 1:P
        if (n-p*d)>0 && (n-p*d)<N_fft
            x(n)=x(n) + (d/W0)*xt(n-p*d,p);
        end
    end
end

end