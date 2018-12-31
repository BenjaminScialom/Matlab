function y = pinkNoise(N)
%creates randomized pink noise of length N

%must be even for FFT to work correctly
if rem(N,2)
    M = N+1;
else
    M=N;
end

%sigma = 1, mu = 0 default
x = randn(1,M);

%fast fourier transform
x = fft(x);

%want to do 1/f multiplication to make noise "pink"
points = M/2 + 1;
n = 1:points;
n = sqrt(n);

%multiply left half of spectrum so PSD is inversely proportional to
%frequency by the 1/f factor
X(1:points) = x(1:points)./n;

%same for right half but make sure to leave out DC and nyquist freqs
X(points+1:M) = real(X(M/2:-1:2)) - 1i*imag(X(M/2:-1:2));

%return to time domain
y = ifft(X);

%don't want anything imaginary
y = real(y(1,1:N));

%normalize?
y = y./max(abs(y));

end