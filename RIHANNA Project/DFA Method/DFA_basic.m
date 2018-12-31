function [scale, F_DFA, F_DFA_corr] = DFA_basic(Signal,q,order,overlap,correction_num);
 %% Input : 
 %%       Signal : vector to analyse
 %%       q : mono or multi fractal q=(2:6)
 %%       order : linear regression order
 %%       overlap : window overlap
 %%       correction_num : un-modified DFA average number
 %% Output : 
 %%       scale : window on which is compute the DFA
 %%       F_DFA : q-th order fluctuation function
 %%       F_DFA_corr : modified DFA on <correction_num> average

<<<<<<< Updated upstream
=======
%% Init var
max = floor(length(Signal)*0.1);
%scale = [10:10:max];
%scale=[16 ,32 ,64, 128, 256, 512]; % scale from the windows%
<<<<<<< Updated upstream
scale = (3:max);
=======
scale = (10:max);
>>>>>>> Stashed changes
>>>>>>> Stashed changes

%% Windows
max = floor(length(Signal)*0.1);
scale = (10:max);
L=length(scale);

%% Variables
F_DFA=zeros(1,L);
absis=(1:length(Signal));
N=length(Signal);

%%STEP 1 : Signal integrated
Signal=cumsum(Signal-mean(Signal));
Signal_inv=flip(Signal);
absis_inv=flip(absis);

%%STEP 2: F_DFA calculation 
for kk=1:L
    N_trame=scale(kk);
    [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N_trame,overlap,'Rectangle');
    [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame,overlap,'Rectangle');
    RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
    F_DFA(1,kk)=(mean(RFN.^q)).^(1/q);
end
<<<<<<< Updated upstream
Poly=reg_lin(log10(scale),log10(F_DFA),order);
=======
<<<<<<< Updated upstream
Poly=reg_lin(log10(scale),log10(Fn),order);
=======
Poly=reg_lin(log10(scale),log10(Fn),order)
>>>>>>> Stashed changes

>>>>>>> Stashed changes
Alpha=Poly(2);

%% STEP 3: F_DFA_corr calculation
if correction_num > 1 && Alpha < 1 
  for e = 1:correction_num
    
    Signal_shuff = Signal(randperm(length(Signal))); 
    cum_perm = cumsum(Signal_shuff - mean(Signal));
    Signal_inv_shuff =flip(Signal_shuff);
    
    for kk=1:length(scale)
      N_trame=scale(kk);
      [Signal_cut,Absis_cut]=Decoupage_RI(Signal_shuff',absis,N_trame,overlap,'Rectangle');
      [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv_shuff',absis_inv,N_trame,overlap,'Rectangle');
      RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
      F_DFA_shuff(e,kk) = (mean(RFN.^q)).^(1/q);
    end
    
  end


<<<<<<< Updated upstream
%% Correction coefficient K
=======
figure,
scatter(log10(scale),log10(Fn));
hold on
plot(log10(scale),RegLine);
var(Fn)

>>>>>>> Stashed changes

  scalebis = find(scale > N/20);
  scalebis(2:end) = []; % index where scale ~ N/20

  K = sqrt(mean(F_DFA_shuff.^2)).*sqrt(scalebis)./(sqrt(mean(F_DFA_shuff(:,scalebis).^2)).*sqrt(scale));
  figure, 
  plot(scale,K);
  F_DFA_corr = F_DFA./K;
else
F_DFA_corr = [];
end

end

