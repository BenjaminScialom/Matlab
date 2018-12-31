function [ periodo ] = periodogramme_2( signal,pas )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


N = length(signal);
signal_2 = [signal signal signal];
periodo = zeros(1,N);

for i = 1:1:N
    periodo(i) = mean(signal_2(N+i-ceil(pas/2):N+i+ceil(pas/2)));
end

end

