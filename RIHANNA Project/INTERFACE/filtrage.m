function [ h ] = filtrage( d,f,bbg )
%%  Filter function 
%   This function will compute the filter function h based on its poles
%%  INPUT
%   d : the pole vector
%   f : the frequencies vector based on our initial signal
%%  OUTPUT
%   h : the filter function associated to the poles

x = filter(1,d,bbg);
figure(12)
plot(-1/2:1/length(x):1/2-1/length(x),1/length(x)*abs(fftshift(fft(x))).^2)
h = freqz(1,d,2*pi*f);

end

