clear all, clc

figure
hold on

m = zeros(1,1000);
p=0.05:0.05:0.5;

g=[3];
c = codconv(m,g);
for i = 1:length(p)
    y = bsc(c, p(i));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(p,P,'g-o','MarkerFaceColor', 'g');

g=[5 7];
c = codconv(m,g);
for i = 1:length(p)
    y = bsc(c, p(i));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(p,P,'r-^','MarkerFaceColor', 'r');

g=[15 17];
c = codconv(m,g);
for i = 1:length(p)
    y = bsc(c, p(i));
    d = decodconv(y, g);
    P(i) = sum(abs(d-m))/length(m);
end
plot(p,P,'b-s', 'MarkerFaceColor', 'b');

for i = 1:length(p)
    y = bsc(m, p(i));
    P(i) = sum(abs(y-m))/length(m);
end
plot(p,P);
title('Probabilité estimée d''erreur', 'FontSize', 20);
xlabel('probabilité d''erreur du canal', 'FontSize', 20);
ylabel('Probabilité d''erreur estimée', 'FontSize', 20);

legend({'g=[3]','g=[5, 7]','g=[15, 17]', 'pas de codage'},'FontSize', 25, 'Location','southeast')
hold off