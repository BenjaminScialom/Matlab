<<<<<<< Updated upstream
function [K] = correction (Signal,absis,scale,recouvrement,L,order)
  
absis_inv=flip(absis);
Fnbis = 0;
K = ones(1,L);

%scale = (10:floor(length(Signal)/20));
Fn = zeros(1,length(scale));
Fn_perm = zeros(1,length(scale));

for j=1:1
  
  %% F_shuffled(s)
  Signal_perm = Signal(randperm(length(Signal))); 
  Signal_inv=flip(Signal);

  for kk=1:length(scale)
      N_trame=scale(kk);
      [Signal_cut,Absis_cut]=Decoupage_RI(Signal_perm',absis,N_trame, recouvrement,'Rectangle');
      [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame, recouvrement,'Rectangle');
      RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
      Fn_perm(1,kk)= mean(RFN.^2);
  end
  Fn = Fn + Fn_perm;
  
  %% F_shuffled(s')
  scalebis = floor(length(Signal)/20);
  N = scalebis;
  [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N, recouvrement,'Rectangle');
  [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N, recouvrement,'Rectangle');
  RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
  Fnbis = Fnbis + mean(RFN.^2);

end

Fn = Fn/1;
Fnbis = Fnbis/1;

%% K coef
for kk=1:length(scale)
K(1,kk)=(sqrt(Fn(1,kk))*sqrt(scalebis))./(sqrt(Fnbis)*sqrt(scale(1,kk)));
end


 end
=======
function [K] = correction (Signal,absis,scale,recouvrement,Alpha,L,order)
Signal_inv=flip(Signal);
absis_inv=flip(absis);


%% F_shuffled(s)
Signal = Signal(randperm(length(Signal))); 
for kk=1:L
    N_trame=scale(kk);
    [Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N_trame, recouvrement,'Rectangle');
    [Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N_trame, recouvrement,'Rectangle');
    RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
    Fn(1,kk)=sqrt(mean(RFN.^2));
end
%% F_shuffled(s')
scalebis = length(Signal)/20;
N = scalebis;
[Signal_cut,Absis_cut]=Decoupage_RI(Signal',absis,N, recouvrement,'Rectangle');
[Signal_inv_cut,Absis_inv_cut]=Decoupage_RI(Signal_inv',absis_inv,N, recouvrement,'Rectangle');
RFN=Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order);
Fnbis=sqrt(mean(RFN.^2));


%% K
for kk=1:L
    K(1,kk)=(sqrt(Fn(1,kk).^2)*sqrt(scalebis))./(sqrt(Fnbis.^2)*sqrt(scale(kk)));
end
  
  
 endfunction
>>>>>>> Stashed changes
