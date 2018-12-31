% This code is written by PAUVERT Simon and SCIALOM Benjamin
clearvars -except database; % This line replaces the usual "clear"
% Resets matlab workspace except database

close all; % Closes every open figure
clc;       % Clears the command window

%% Load database

if ~exist('database','var')
    load('database'); %Loads database
end
N_DB_FILES = size(database,2);

%% TEST :

[ r, k, s ] = generate_query(database,4,0.01);
rho_star = zeros(1,N_DB_FILES);
for j=1:N_DB_FILES
    Fs = database{j}.Fs;
    x = database{j}.Samples;
    [rho,m] = score_v1(x,r,Fs);
    rho_star(j) = rho;
end 
[correlation,indexfound]=max(rho_star);

plot(1:N_DB_FILES,rho_star)
ylabel('correlation maximums')
xlabel('song index')
title('SNR = 10dB')


