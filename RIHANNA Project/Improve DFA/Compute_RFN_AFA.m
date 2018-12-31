function [RFN_AFA,Signal_stitched ] = Compute_RFN_AFA(Signal_cut,Signal_cut_fit,Signal_inv_cut,Signal_inv_cut_fit)
%%This function calculate the regression lineaire for each value of the Signal 
%%INPUT : Signal_cut : Signal_cut in N_tram 
%%        Signal_cut_fit : Signal_fit cut in N_tram       
%%        Signal_inv_cut: Signal_cut in N_tram by starting at the end 
%%        Signal_inv_cut_fit : Signal reversed fit cut in N_tram
%%OUTPUT: RFN_AFA: Calcul of Fn on each trame 
%%        Signal_stitched: matrix return the signal after treatment with coefficient

% Variable initialization
[L,M]=size(Signal_cut);
Signal_stitched=zeros(L,M);
RFN_AFA=zeros(1,2*L);

% In order not to disregard this part of the series , the same procedure is repeated starting from the opposite end. 
% That explains the 2*L length 

for kk=1:2*L
     if(kk<L+1) %from the beginning of the time signal
          Signal_stitched(kk,:)=Signal_cut_fit(kk,:);
          RFN_AFA(1,kk)=sqrt(mean((Signal_cut(kk,:)-Signal_cut_fit(kk,:)).^2));
     else %from the end (reverse)
          RFN_AFA(1,kk)=sqrt(mean((Signal_inv_cut(kk-L,:)-Signal_inv_cut_fit(kk-L,:)).^2));
     end 
     
end
end

