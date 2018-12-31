% This code is written by PAUVERT Simon and SCIALOM Benjamin
clearvars -except database; % This line replaces the usual "clear"
% Resets matlab workspace except database

close all; % Closes every open figure
clc;       % Clears the command window

%% Load database

if ~exist('database','var')
    load('database'); %Loads database
end
if ~exist('us_query','var')
    load('us_query'); %Loads us_query
end

N_DB_FILES = size(database,2); % The number of files in the database
Fs = database{5}.Fs

%% TASK 15 - 16

query = resamp(us_r,Fs,us_fs);

%% TASK 18

sample = database{12}.Samples;
Fs = database{12}.Fs;


Nfft = 1024;
Nf = 12; % number of filters
P = (Nfft/2)+1; % length of each filters
F = [0 Fs/2]; % frequency domain

[ Y, f, c ] = trifbank( Nf, P, F, Fs) % Y is a matrix of the 12 features per window, 
%f is a vector of the frequencies of each feature, 
%C cut-off frequencies of each filter.


plot( f, Y );
xlabel( 'Frequency (Hz)' ); ylabel( 'Weight' ); set( gca, 'box', 'off' ); 


