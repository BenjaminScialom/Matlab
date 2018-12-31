function [ rho_star, m_star] = score_v1( x,r,Fs )
%SCORE computes the score function between x and r
%
% [rho_star, m_star] = SCORE_V1(x,r) computes the score function between a
% database signal x and a query signal r and returns the score rho_star and
% the position where the query is found m_star
% INPUT
% 
% x: database signal
% r: query signal
% 
% OUTPUT 
% 
% rho_bar: score
% m_bar: guessed position of r within x
% rho : the complete inter-correlation function
Nh = numel(r);
N_fft = 2^(floor(log2(2*Nh-1)));
w = ones(Nh,1);

[X,f,t] = stft(x,w,Nh,N_fft,Fs);
r = r(end:-1:1);
R = fft(r,N_fft);
R = R.';
R = repmat(R,1,size(X,2));
Y = X.*R;
y = istft(Y,w,Nh,N_fft,Fs);

[Xsq,f,~]=stft((x.^2),w,Nh,N_fft,Fs);
u = ones(1,Nh);
U = fft(u,N_fft);
U = U.';
U = repmat(U,1,size(Xsq,2));
Ysq = Xsq.*U;
ysq = istft(Ysq,w,Nh,N_fft,Fs);

ynorm = (y.^2)./(sum(r.^2)*ysq);

[rho_star,m_star] = max(ynorm);

end