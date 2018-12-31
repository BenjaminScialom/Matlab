function [ r, k, s ] = generate_query( database, T, SNR)
% GENERATE_QUERY generates a noisy query from the database
% 
% [r, k, d] = GENERATE_QUERY(database, T, SNR) generates a noisy query
% from the database
%
% INPUT database: the database
% T: duration of the query in seconds
% SNR: Signal to Noise Ratio
%
% OUTPUTS r: query
% k: index of the database song
% s: index of the first extracted element of x^(k)

%% Initialisation of dome project constants

N_DB_FILES = size(database,2); % The number of files in the database
k=randi(N_DB_FILES);
Fs = database{k}.Fs;
unknown = database{k}.Samples;
s = randi(numel(unknown)-T*Fs);
n = s:s+T*Fs;
r=unknown(n);

q = sum(abs(r).^2);
var = q/(SNR*numel(n));

hold on
r = r + var*randn(1,numel(n));

end

