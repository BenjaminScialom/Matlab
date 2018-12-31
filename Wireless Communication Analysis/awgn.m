function [ y ] = awgn( c, sigma2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

y=c+sqrt(sigma2)*randn(size(c));


end

