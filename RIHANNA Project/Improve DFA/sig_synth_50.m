clear all, clc, close all;

load('WEI_15.mat');
M = load('WEI_15.mat');
 
order = 1; % order of linear regression order=[1:3]
q = 2; % mono or multi fractal q=[2:6]
overlap = 0; % windowing overlap
correction_num = 1; % if K_correction : average on <correction_number> number (1 for un-modified DFA)
tic
  for i=1:50
    
    file = sprintf('WEI_1_%d',i); %choose the signal
    signal  = M.(file);
    signal=signal(1:1024); %to compute most faster
    [scale, F_DFA, F_DFA_corr,~,~] = DFA_basic(signal',q,order,overlap,correction_num);
    Poly=reg_lin(log10(scale),log10(F_DFA),order);
    alpha(i)=Poly(2);
  end
toc
m = mean(alpha);
v = var(alpha);
  
