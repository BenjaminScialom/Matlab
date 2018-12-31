function [V] = my_Welch(s,w,D)

N = length(s);
L = length(w);
k = 1+floor((N-L)/(L-D));
DSP=0;

    for i=0:k-1
        x = s(1+i*(L-D):L+i*(L-D));
        y = x.*w;
        DSP=DSP+abs(fft(y)).^2;
    end

W = sum(abs(w.^2))./N;
V= DSP./(W*k*L);

figure, 
plot(10*log10(V));
xlim([0 L/2]);
title('Notre periodogramme de Welch ');

end


