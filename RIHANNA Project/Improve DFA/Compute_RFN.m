function [RFN,Signal_stitched ] = Compute_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order,backward)
%%This function computes the regression lineaire for each value of the Signal 
%%INPUT : Signal_cut : Signal_cut in N_tram 
%%        Absis_cut : absis cut in N_trme 
%%        Signal_inv_cut: Signal_cut in N_tram by starting at the end 
%%        Absis_inv_cut : absis_cut in N_trme by starting at the end 
%%        m         : order of the polynome
%%OUTPUT: RFN: Calcul of Fn on each trame 
%%        Signal_stitched: matrix return the signal after treatment with coefficient


if (backward)
    
  % Variable initialization
  [L,M]=size(Signal_cut);
  Signal_stitched=zeros(L,M);
  RFN=zeros(1,2*L); 

  % In order not to disregard this part of the series , the same procedure is repeated starting from the opposite end. 
  % That explains the 2*L length 

  for kk=1:2*L
       if(kk<L+1) %from the beginning of the time signal
            C=reg_lin(Absis_cut(kk,:),Signal_cut(kk,:),order);
            Signal_cut_fit=model(C,Absis_cut(kk,:),order);
            Signal_stitched(kk,:)=Signal_cut_fit(:);
            RFN(1,kk)=sqrt(mean((Signal_cut(kk,:)-Signal_cut_fit).^2));
       else %from the end (reverse)
            C=reg_lin(Absis_inv_cut(kk-L,:),Signal_inv_cut(kk-L,:),order);
            Signal_inv_cut_fit=model(C,Absis_inv_cut(kk-L,:),order);
            RFN(1,kk)=sqrt(mean((Signal_inv_cut(kk-L,:)-Signal_inv_cut_fit).^2));
       end  
  end
  
else
  
   % Variable initialization
  [L,M]=size(Signal_cut);
  Signal_stitched=zeros(L,M);
  RFN=zeros(1,L); 

  for kk=1:L
            C=reg_lin(Absis_cut(kk,:),Signal_cut(kk,:),order);
            Signal_cut_fit=model(C,Absis_cut(kk,:),order);
            Signal_stitched(kk,:)=Signal_cut_fit(:);
            RFN(1,kk)=sqrt(mean((Signal_cut(kk,:)-Signal_cut_fit).^2)); 
  end
  
end


end

