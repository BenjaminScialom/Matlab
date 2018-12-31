function [rho_bar, m_bar, rho]=score_v0(x,r)
%SCORE_V0 computes the score function between x and r 
%
%[rho_bar, m_bar, rho]=SCORE_V0(x,r) computes the score function between a
%database signalx and a query signal r and returns the score rho_bar and
%the position where the query is found m_bar
%
%INPUT   x:database signal
%        r:query signal
%
%OUTPUTS rho_bar: score
%          m_bar: guessed position of r within x
%           rho : the complete inter correlation function
%

N=numel(r);
w=ones(1,N);
rho = (conv(r(end:-1:1),x).^2)./(sum(r.^2)*conv(w,x.^2));
[rho_bar,m_bar]=max(rho);

end