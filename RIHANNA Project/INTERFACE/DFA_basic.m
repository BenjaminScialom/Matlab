function [frame, F_DFA, F_DFA_corr,Signal_DFA_R,Signal] = DFA_basic(Signal,q,order,correction,N_display,backward,frame)
%% This function computes the detrended fluctuation analysis
 %% Input : 
 %%       Signal : vector to analyse
 %%       q : mono or multi fractal q=(2:6)
 %%       order : linear regression order
 %%       correction : option for modified DFA with correction
 %%       N_display : option for displaying signal cut in frame of length=N_display
 %%       backward : option for DFA compute only forward or forward and backward (0:forward/1:b/f)
 %%       frame : frame for wich DFA is computed
 %% Output : 
 %%       frame : frame for which DFA is computed
 %%       F_DFA : q-th order fluctuation function
 %%       F_DFA_corr : modified DFA with correction
 %%       Signal_DFA_R : signal after DFA processing
 %%       Signal : signal given integrated


L=length(frame);

%% Variables
F_DFA=zeros(1,L);
absis=(1:length(Signal));
N=length(Signal);

%%STEP 1 : Signal integrated
Signal=cumsum(Signal-mean(Signal));
Signal_inv=flip(Signal);
absis_inv=flip(absis);

%%STEP 2: F_DFA calculation 
for kk=1:L %loop on the window frame 
    N_frame=frame(kk);
    [Signal_cut,Absis_cut]=Cut_window(Signal',absis,N_frame);
    
    if (backward) %% Option to compute DFA on signal backward
      [Signal_inv_cut,Absis_inv_cut]=Cut_window(Signal_inv',absis_inv,N_frame);
      [RFN,Signal_DFA]=Compute_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order,backward);
    else %% or just for forward
      [RFN,Signal_DFA]=Compute_RFN(Signal_cut,Absis_cut,0,0,order,backward);
    end

    if(kk==N_display) %in order to plot the Signal cut in N_display frame
        Signal_DFA_R=Reconstruction_RI(Signal_DFA);
    end
    
    F_DFA(1,kk)=(mean(RFN.^q)).^(1/q);
end
Poly=reg_lin(log10(frame),log10(F_DFA),order);
Alpha=Poly(2);

%% STEP 3: F_DFA_corr calculation
if correction == 1 && Alpha < 1 
  for e = 1:10 %several computations of the shuffled time series
    
    Signal_shuff = Signal(randperm(length(Signal))); 
    Signal_shuff = cumsum(Signal_shuff - mean(Signal));
    Signal_inv_shuff =flip(Signal_shuff);
    
    for kk=1:length(frame)
      N_frame=frame(kk);
      [Signal_cut,Absis_cut]=Cut_window(Signal_shuff',absis,N_frame);
      
      if (backward) %% Option to compute DFA on signal backward
        [Signal_inv_cut,Absis_inv_cut]=Cut_window(Signal_inv_shuff',absis_inv,N_frame);
        [RFN,Signal_DFA]=Compute_RFN(Signal_cut,Absis_cut,Signal_inv_cut,Absis_inv_cut,order,backward);
      else %% or just for forward
        [RFN,Signal_DFA]=Compute_RFN(Signal_cut,Absis_cut,0,0,order,backward);
      end
    
    
      F_DFA_shuff(e,kk) = (mean(RFN.^q)).^(1/q);
    end
    
  end


%% Correction coefficient K

  framebis = find(frame > N/20);
  framebis(2:end) = []; % index where frame ~ N/20

  K = sqrt(mean(F_DFA_shuff.^2)).*sqrt(framebis)./(sqrt(mean(F_DFA_shuff(:,framebis).^2)).*sqrt(frame));
%   figure, 
%   plot(frame,K);
%   title('Correction K ');
  F_DFA_corr = F_DFA./K;
else
  F_DFA_corr = [];
end

end

