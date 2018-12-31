function [ D_s, A_s ] = Cut_window(signal,xabsis,N_trame)
%% this function aims to cut the signal input into frames 
%%  INPUTS :
%% - signal
%% - N_trame : size of frame 
%%  OUTPUTS : 
%% - D_s : matrix of vector signal
%% - A_s : matrix of vector absis

N_s = length(signal);

N_e = floor(N_s/N_trame);

D_s=zeros(N_e,N_trame);
A_s=zeros(N_e,N_trame);

D_s = reshape(signal(1:N_e*N_trame),[N_trame N_e])';
A_s = reshape(xabsis(1:N_e*N_trame),[N_trame N_e])';

end