<<<<<<< Updated upstream
function [Alpha] = LR_DFA (Signal, order)
 %% Input : 
 %%       Signal : vector to analyse
 %%       order : linear regression order
 %% Output : 
 %%       alpha : coefficient from DFA

%% Init var
max = floor(length(Signal)*0.1);
scale = [3:max];
%scale=[16 ,32 ,64, 128, 256, 512, 1024]; % scale from the windows%

L=length(scale);

Fn=zeros(1,L);
absis=(1:length(Signal));

recouvrement=0; % no overlap

%%STEP 1 : Signal integrated
Signal=cumsum(Signal-mean(Signal));

Signal_inv=flip(Signal);
absis_inv=flip(absis);

%%STEP 2: Fn calculation 
for kk=1:L
    N_trame=scale(kk);
    [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N_trame, recouvrement,'Rectangle');
    [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame, recouvrement,'Rectangle');
    RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
    Fn(1,kk)=sqrt(mean(RFN.^2));
end
Poly=reg_lin(log10(scale),log10(Fn),order);
Alpha=Poly(2);
RegLine=model(Poly,log10(scale),order);
dist1 = sqrt(sum((RegLine-log10(Fn)).^2))

%% Disp functions 
figure,
scatter(log10(scale),log10(Fn));
hold on
plot(log10(scale),RegLine);


%% STEP 3 : Correction function K
K = correction(Signal,absis,scale,recouvrement,L,order);



%% STEP 4 : DFA fluctuation function Fn_mod
Fn_mod = Fn./K;


Poly_mod=reg_lin(log10(scale),log10(Fn_mod),order);
Alpha2=Poly_mod(2);
RegLine2=model(Poly_mod,log10(scale),order);

%% Disp functions

scatter(log10(scale),log10(Fn_mod));
hold on
plot(log10(scale),RegLine2);

dist2 = sqrt(sum((RegLine2-log10(Fn_mod)).^2))

figure, 
plot(log10(scale),log10(K));

end
=======
function [Alpha] = LR_DFA (Signal, order)
 %% Input : 
 %%       Signal : vector to analyse
 %%       order : linear regression order
 %% Output : 
 %%       alpha : coefficient from DFA

%% Init var
max = floor(length(Signal)*0.1);
scale = [3:max];
%scale=[16 ,32 ,64, 128, 256, 512, 1024]; % scale from the windows%

L=length(scale);

Fn=zeros(1,L);
absis=(1:length(Signal));

recouvrement=0; % no overlap

%%STEP 1 : Signal integrated
Signal=cumsum(Signal-mean(Signal));

Signal_inv=flip(Signal);
absis_inv=flip(absis);

%%STEP 2: Fn calculation 
for kk=1:L
    N_trame=scale(kk);
    [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N_trame, recouvrement,'Rectangle');
    [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame, recouvrement,'Rectangle');
    RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
    Fn(1,kk)=sqrt(mean(RFN.^2));
end
Poly=reg_lin(log10(scale),log10(Fn),order);
Alpha=Poly(2)
RegLine=model(Poly,log10(scale),order);
dist1 = sqrt(sum((RegLine-log10(Fn)).^2))

%% Disp functions 
figure,
scatter(log10(scale),log10(Fn));
hold on
plot(log10(scale),RegLine);


%% STEP 3 : Correction function K
K = correction(Signal,absis,scale,recouvrement,Alpha,L,order);

%% STEP 4 : DFA fluctuation function Fn_mod
Fn_mod = Fn./K;

Poly=reg_lin(log10(scale),log10(Fn_mod),order);
Alpha=Poly(2)

%% Disp functions
RegLine2=model(Poly,log10(scale),order);
figure,
scatter(log10(scale),log10(Fn_mod));
hold on
plot(log10(scale),RegLine2);
dist1 = sqrt(sum((RegLine2-log10(Fn_mod)).^2))


end
>>>>>>> Stashed changes
