function [Signal_mean_recons,Signal_inv_mean_recons]=Fitting(Signal_cut_ovlp,Absis_cut_ovlp,Signal_inv_cut_ovlp,Absis_inv_ovlp,order,n)
%%This function consists to find the polynom of on an order 1 which smooth
%%at the best to the signal
%%INPUT : Signal_cut_ovlp : Signal_cut in N_tram with n+1 overlap
%        Absis_cut_ovlp : absis cut in N_trame with n+1 overlap
%        Signal_inv_cut_ovlp: Signal_cut in N_tram by starting at the end
%        with n+1 overlap
%        Absis_inv_ovlp : absis_cut in N_trme by starting at the end with
%        n+1 overlap
%        order         : order of the polynome
%        n = scale(kk) scale at the kk loop
%
%%OUTPUT : 
%        Signal_mean_recons: signal by having in consideration the 2
%        polynom
%        Signal_inv_mean_recons : signal_reverse by having in consideration the 2
%        polynom


%%Description of the variable 
[L,column]=size(Signal_cut_ovlp);
N_inde=column-(n+1);
N_s=(L)*N_inde+(n+1);

%%Construction of output signals
Signal_mean_recons=zeros(1,N_s);
Signal_inv_mean_recons=zeros(1,N_s);
ovlp=2*n+1;
%%First N_indep points are put in the output signal
Coeff_fit_start=reg_lin(Absis_cut_ovlp(1,1:ovlp),Signal_cut_ovlp(1,1:ovlp),order);
Signal_mean_recons(1,1:N_inde)=model(Coeff_fit_start,Absis_cut_ovlp(1,1:N_inde),order);

%%for the reverse signal
Coeff_fit_inv_start=reg_lin(Absis_inv_ovlp(1,1:ovlp),Signal_inv_cut_ovlp(1,1:ovlp),order);
Signal_inv_mean_recons(1,1:N_inde)=model(Coeff_fit_inv_start,Absis_inv_ovlp(1,1:N_inde),order);

%%Index for the fullfilment of the signal
start_s=N_inde+1;
end_s=start_s+n;

%Construction of the new signal 
for kk=1:L-1%loop on the signal_cut 
         Signal_mean=Mean_Average( Signal_cut_ovlp,Absis_cut_ovlp,n,kk,order);
         Signal_mean_inv=Mean_Average(Signal_inv_cut_ovlp,Absis_inv_ovlp,n,kk,order);
         Signal_mean_recons(1,start_s:end_s)=Signal_mean(1,:);
         Signal_inv_mean_recons(1,start_s:end_s)=Signal_mean_inv(1,:);
         start_s=end_s;
         end_s=start_s+n;
end

%%the n+1 last number for the signal
Coeff_fit_end=reg_lin(Absis_cut_ovlp(L,1:end),Signal_cut_ovlp(L,1:end),order);
Signal_mean_recons(1,end-(n+1):end)=model(Coeff_fit_end,Absis_cut_ovlp(L,end-(n+1):end),order);

%%for the reverse signal
Coeff_fit_inv_end=reg_lin(Absis_inv_ovlp(L,1:end),Signal_inv_cut_ovlp(L,1:end),order);
Signal_inv_mean_recons(1,end-(n+1):end)=model(Coeff_fit_inv_end,Absis_inv_ovlp(L,end-(n+1):end),order);
end

