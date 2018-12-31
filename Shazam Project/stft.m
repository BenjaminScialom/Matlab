function [ X , f , t ] = stft( x, w, d, N_fft, Fs )
% [X,f,t] = stft(x,w,d,N_fft,Fs)
% This function computes the stft for m = [0,d,2d,3d...]
% %INPUTS
%     x: the signal
%     w: a window
%     d: is the shift between two successive windows
%     N_fft: the size of FFTs
%     Fs: the sampling rate of x
% OUTPUTS
%     X: a matrix of N_fft lines and P columns
%         P is the number of elements of m
%     f: a column vector of frequencies
%     t: a row vector containing times of windows start
N=numel(w);
M =floor(((numel(x)-N)/d)+1);
frames = zeros(N,M);
X = zeros(N_fft,M);
wrep = repmat(w,1,M-1);
for k = 0 : M-1
        frames(:,k+1)=x(k*d+(1:N));
end
frames = conj(frames).*w;
X = (fft(frames,N_fft,1));
t=0:d/Fs:(M-1)*d/Fs;
f=(-1/2:1/N_fft:1/2-1/N_fft)*Fs;

end