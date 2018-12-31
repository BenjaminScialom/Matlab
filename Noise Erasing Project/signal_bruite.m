function y = signal_bruite (s,RSB)

b = randn(size(s));
alpha = (1/10^(RSB/10))* (sum(s.^2)/sum(b.^2))
y = s + sqrt(alpha).*b;

end
