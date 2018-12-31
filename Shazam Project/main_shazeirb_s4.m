% This code is written by PAUVERT Simon and SCIALOM Benjamin
clearvars -except database; % This line replaces the usual "clear"
% Resets matlab workspace except database

close all; % Closes every open figure
clc;       % Clears the command window

%% Load database

if ~exist('database','var')
    load('database'); %Loads database
end

%% Initialisation of dome project constants

N_DB_FILES = size(database,2); % The number of files in the database
numextract=randi(N_DB_FILES);
Fs1 = database{numextract}.Fs;
unknown = database{numextract}.Samples;
extract=unknown(1:4*Fs1);

% TASK 7-8 :
% tic
% 
% for k=1:18;
%     Fs = database{k}.Fs;
%     x = database{k}.Samples;
%     [rho_bar,m_bar,rho] = score_v0(x,extract);
%     rho_star(k) = rho_bar;
% end
% 
% [o,p]=max(rho_star)
% toc
%% TASK 10-11
tic
rho_star = zeros(1,N_DB_FILES);
for k=1:N_DB_FILES
    Fs = database{k}.Fs;
    x = database{k}.Samples;
    [rho,m] = score_v1(x,extract,Fs);
    rho_star(k) = rho;
end 
[d,e]=max(rho_star);
toc
semilogy(1:N_DB_FILES,rho_star);
xlabel('song index');
ylabel('Correlation logarithm');
