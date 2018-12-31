function y = brownNoise(N)
%brown noise is the integral of white noise??

y = randn(1,N);

y = cumsum(y);

%normalize?
y = y./max(abs(y));

end