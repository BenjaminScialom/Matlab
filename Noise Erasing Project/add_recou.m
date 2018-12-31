function s = add_recou (A,w,overlap)

[L,N] = size(A);

% Mise en application de la formule
win=repmat(w(L-overlap+1:L)+w(1:overlap),1,N-1);

% Estimation grace a l'overlap
tempo=A(overlap+1:L-overlap,1:N)./repmat(w(overlap+1:L-overlap),1,N);
r=(A(L-overlap+1:L,1:N-1)+A(1:overlap,2:N))./win;

% Gestion premiere & derniere colonnes
Prem=A(1:overlap,1)./w(1:overlap);
der=A(L-overlap+1:L,N)./w(L-overlap+1:L);

% Reconstruction du signal
s=[tempo; r der];
s=s(:);
s=[Prem;s];

end
