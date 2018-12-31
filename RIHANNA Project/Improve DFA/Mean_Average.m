function [ Signal_mean ] = Mean_Average( Signal_cut_ovlp,Absis_cut_ovlp,n,kk,order)
% %%this function did the mean average and return the new signal
%INPUT : Signal_cut_ovlp : Signal_cut in N_tram with n+1 overloap
%        Absis_cut_ovlp : absis cut in N_trme with n+1 overloap
%        n: number of point in common in the two signal ( overlap
%        corresponding at the scale
%        kk : range of matrix corresponding to  points to approximate 
%        order         : order of the polynome
%OUTPUT: RFN: Calcul of Fn on each trame

% Declaration of variable
Window_1=Absis_cut_ovlp(kk,:);
Window_2=Absis_cut_ovlp(kk+1,:);
Signal_test1=Signal_cut_ovlp(kk,:);
Coeff_fit_1=reg_lin(Window_1,Signal_test1,order); %coefficients of the polynomial for the signal 1
Coeff_fit_2=reg_lin(Window_2,Signal_cut_ovlp(kk+1,:),order);%coefficients of the polynomial for the signal 2
Signal_1=model(Coeff_fit_1,Window_1,order);
Signal_2=model(Coeff_fit_2,Window_2,order);

% Construction of the new window
Signal_mean=zeros(1,n+1);

for l=1:n+1%loop on the n+1 point overlap for smoothing the signal
    Signal_mean(1,l)=(1-((l-1)/n))*Signal_1(1,l+n)+((l-1)/n)*Signal_2(1,l);
end

end