function [scale, F_AFA,Signal_AFA_R,Signal ] = AFA_basic(Signal,q,order)
%% this functions aims to settle DFA issues with discontinuities
 %% Input : 
 %%       Signal : vector to analyse
 %%       q : mono or multi fractal q=(2:6)
 %%       order : linear regression order
 %%       overlap : window overlap or number
 %%       correction_num : un-modified DFA average number
 %% Output : 
 %%       scale : window on which is compute the DFA
 %%       F_AFA : q-th order fluctuation function
 %%       Signal_AFA_R : signal after AFA processing
%% Windows
max = floor(length(Signal)*0.1); %to be sure to have a integer 
scale = (10:max); %10 to 10% of the signal ( from research done with this scale ) 
L=length(scale);

%% Variables
F_AFA=zeros(1,L);
absis=(1:length(Signal));

%%STEP 1 : Integrated signal 
Signal=cumsum(Signal-mean(Signal));
Signal_inv=Signal;
absis_inv=absis;

%%STEP 2: F_AFA computing

%%ETAPE 1 : PARTITIONNING 
for kk=1:L
    w=scale(kk);
    n=ceil((w-1)/2);
    [Signal_cut_ovlp,Absis_cut_ovlp]=Cut_number(Signal,absis,n);
    [Signal_inv_cut_ovlp,Absis_inv_ovlp]=Cut_number(Signal_inv,absis_inv,n);
    
  
    %%ETAPE 2 : OVERLAPPING REGION/SIGNAL PROCESSING
    [Signal_mean_recons,Signal_inv_mean_recons]=Fitting(Signal_cut_ovlp,Absis_cut_ovlp,Signal_inv_cut_ovlp,Absis_inv_ovlp,order,n);
     
    %%ETAPE 3 : RFN Computing
    [Signal_mean_cut_ovlp,~]=Cut_window(Signal_mean_recons',absis,w);
    [Signal_cut,~]=Cut_window(Signal(1:length(Signal_mean_recons))',absis,w);
    [Signal_inv_mean_cut_ovlp,~]=Cut_window(Signal_inv_mean_recons',absis_inv,w);
    [Signal_cut_inv,~]=Cut_window(Signal_inv(1:length(Signal_inv_mean_recons))',absis,w);
    [RFN,~]=Compute_RFN_AFA(Signal_cut,Signal_mean_cut_ovlp,Signal_cut_inv,Signal_inv_mean_cut_ovlp);
    if(w==scale(L))
        Signal_AFA_R=Gather_number(Signal_mean_recons,n);
    end
    
    F_AFA(1,kk)=(mean(RFN.^q)).^(1/q);
    
    if(n==scale(L))
        Signal_AFA_demo =Reconstruction_RI(Signal_stitched_AFA);
    end
    
end
 end

