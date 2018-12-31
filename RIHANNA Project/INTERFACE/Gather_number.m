function [ Signal_recons ] = Gather_number(Signal_cut,n )
%%this function aims to reconstitute the signal 
%INPUT : Signal_cut : Signal cut into N_trame
%        n : number given with how many number the signal have been cut (
%        scale ) 
%OUTPUT:  Signal_recons = signal which have been reconstructed

% Variable declaration
[line,colonne]=size(Signal_cut);
N_inde=colonne-(n+1);
N_s=(line)*N_inde+(n+1);
Signal_recons=zeros(1,N_s);
Signal_recons(1,1:N_inde)=Signal_cut(1,1:N_inde);


%%Index
start_1=N_inde+1;
end_1=start_1+n;
start_s=N_inde+1;
end_s=start_1+n;

for kk=1:line
  Signal_recons(1,start_s:end_s)=Signal_cut(kk,start_1:end_1); 
  start_s=end_s;
  end_s=start_s+N_inde;
end

end

