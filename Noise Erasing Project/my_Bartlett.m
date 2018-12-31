function [V] = my_Bartlett(s,w)
% Barlett periodrogramm

% Initialisation des variables
N = length(s);
L = length(w);
k = ceil(N/L);
DSP=0;
s=cat(2,s,zeros(1,(k*L)-N));

% calcule de la DSP pdu signal
    for i=0:k-1
        x = s(1+i*L:L+i*L);
        DSP = DSP+abs(fft(x)).^2;  
    end
    
% Moyennage
V=DSP./k*L;

% Affichage
figure, 
plot(10*log10(V));
xlim([0 L/2]);
title('Notre periodogramme de Bartlett ');

end

