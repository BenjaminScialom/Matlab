function [RFN ] = Calcul_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order)
%This function calculate the regression lineaire for each value of the
%INPUT : Signal_cut : Signal_cut in N_tram 
%        Absis_cut : absis cut in N_trme 
%        Signal_inv_cut: Signal_cut in N_tram by starting at the end 
%        Absis_inv_cut : absis_cut in N_trme by starting at the end 
%        m         : order of the polynome
%OUTPUT: RFN: Calcul of Fn on each trame 

[L,M]=size(Signal_cut);
RFN=zeros(1,2*L);
for kk=1:2*L
     if(kk<L+1)
         C=polyfit(Absis_cut(kk,:),Signal_cut(kk,:),order);
         Signal_cut_fit=polyval(C,Absis_cut(kk,:));
         RFN(1,kk)=sqrt(mean((Signal_cut(kk,:)-Signal_cut_fit).^2));
     else 
         C=polyfit(Absis_inv_cut(kk-L,:),Signal_inv_cut(kk-L,:),order);
         Signal_inv_cut_fit=polyval(C,Absis_inv_cut(kk-L,:));
         RFN(1,kk)=sqrt(mean((Signal_inv_cut(kk-L,:)-Signal_inv_cut_fit).^2));
     end  
end

end

