clear all, clc

figure
hold on

m = ones(1,10000);
SNR=0:1:10;

g=[3];
c = codconv(m,g);
for i = 1:length(SNR)
    y = awgn(c, 10^(SNR(i)/10));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(SNR,P,'g-o','MarkerFaceColor', 'g');

g=[5 7];
c = codconv(m,g);
for i = 1:length(SNR)
    y = awgn(c, 10^(-SNR(i)/10));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(SNR,P,'r-^','MarkerFaceColor', 'r');

g=[15 17];
c = codconv(m,g);
for i = 1:length(SNR)
    y = awgn(c, 10^(-SNR(i)/10));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(SNR,P,'b-s', 'MarkerFaceColor', 'b');

for i = 1:length(SNR)
    y = awgn(m, 10^(-SNR(i)/10));
    P(i) = sum(abs(y-m))/length(m);
end
plot(SNR,P);
title('Probabilité estimée d''erreur', 'FontSize', 20);
xlabel('SNR', 'FontSize', 20);
ylabel('Probabilité d''erreur estimée', 'FontSize', 20);

legend({'g=[3]','g=[5, 7]','g=[15, 17]', 'pas de codage'},'FontSize', 25, 'Location','northeast')
hold off

