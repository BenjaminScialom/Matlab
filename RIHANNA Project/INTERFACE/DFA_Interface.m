function [ scale_advanced,RegLine_advanced,F_DFA_advanced,Alpha_advanced ,Signal_DFA_R_advanced,Signal_advanced,scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA,Alpha_AFA,RegLine_AFA,scale_DFA, F_DFA,F_DFA_corr,Signal_DFA_R,Signal,Alpha_DFA,RegLine_DFA,RegLine_corr,Alpha_corr] = DFA_Interface(signal,Advanced,N_display,backward,q,correction,AFA,order,frame)
%%The function aims to return important data in order to to the interface.
%%INPUT : signal : signal to treat
%%        Advanced: 1 : mode advenced activated the user can usemore options if he knows 
%%                  0 : Non-advanced method: for someone who don't know but want some basic result
%%        display : (4: N/2) display trend for a signal given with a box of length display
%%        backward : 0 :just forward 
%%                      1 :forward + backward
%%        q :           mono(2) or multi fractal q=[2:6]
%%        correction:   if  K_correction : modified DFA with correction (0 for un-modified DFA)
%%
%%        AFA :  0 (non-compute) else 1 if computation of AFA WATCH if Computation of AFA then Correctif must be equal to 

%%        order : order of linear regression order=[1:3]
% scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA,Alpha_AFA,RegLine_AFA
%%Initialisation of all variable 

scale_AFA=-1;F_AFA=-1;Signal_AFA_demo=-1;Signal_int_AFA=-1;Alpha_AFA=-1;RegLine_AFA=-1;
scale_advanced=-1;RegLine_advanced=-1;F_DFA_advanced=-1;Alpha_advanced=-1;Signal_DFA_R_advanced=-1;Signal_advanced=-1;
scale_DFA=-1; F_DFA=-1;F_DFA_corr=-1;Signal_DFA_R=-1;Signal=-1;Alpha_DFA=-1;RegLine_DFA=-1;RegLine_corr=-1;Alpha_corr=-1;
%%START CODE 

if(Advanced==0) %%Non-advanced method : Interface will show 3 figure : spectrum, all signal with trend in bow of length(display) and the slope of DFA
   
    %%In mode advanced we chose some parameters such as q and
    %%correction_num : q= 2 correction_num = 0
    
    %% DFA COMPUTATIONF_DFA_advanced
    q=2;
    correction=0;
    backward=1;
    order=1;
    frame=[10:lenght(data)/4];
    
    [scale_advanced, F_DFA_advanced,F_DFA_corr_advanced,Signal_DFA_R_advanced,Signal_advanced] = DFA_basic(signal,q,order,correction,N_display,backward,frame);
    Poly=reg_lin(log10(scale_advanced),log10(F_DFA_advanced),order);
    Alpha_advanced=Poly(2);
    RegLine_advanced=model(Poly,log10(scale_advanced),order);

%%FIGURE 1 : 
% figure,SLOPE COPY THE FOLLOWING CODE IN ORDER TO PLOT THE 1 FIGURE  
% scatter(log10(scale_advanced),log10(F_DFA_advanced)); %fitting points figure
% hold on
% plot(log10(scale_advanced),RegLine_advanced);
% axis([min(log10(scale_advanced)) max(log10(scale_advanced)) min(RegLine_advanced) max(RegLine_advanced)]);
% title('Determination of the coefficient Alpha by DFA');
% xlabel('logn');ylabel('Fn');

%%FOR FIGURE 2 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
% figure,
% absis=(1:length(Signal_DFA_R_advanced));
% plot(Signal_advanced);
% 
% %% to appear the line for windows that have been cut 
% % for kk=1:length(Signal_advanced)
% %     if(mod(kk,display)==0)
% %         test(1,kk)=300;
% %     else
% %         test(1,kk)=min(Signal)-15;
% %      end
% % end
% % hold on
% % plot(test)
% 
% hold on
% plot(Signal_DFA_R_advanced)
% axis([min(absis) max(absis) min(Signal_advanced) max(Signal_advanced)]);
% title('Superposition of the integrated signal and the DFA treatment');
% xlabel('Samples');
% ylabel('Value');


%%FOR FIGURE 3 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
% N=2048;
% f=(-1/2:1/N:1/2-1/N);
% X = fftshift(abs(fft(signal,N))); 
% subplot(1,2,2)
% plot(f,X);
% axis([min(f) max(f) min(X) max(X) ]);
% title('Signal Spectrum');
% xlabel('Frequences')




else 
[scale_DFA, F_DFA,F_DFA_corr,Signal_DFA_R,Signal] = DFA_basic(signal,q,order,correction,N_display,backward,frame);
Poly_DFA=reg_lin(log10(scale_DFA),log10(F_DFA),order);
Alpha_DFA=Poly_DFA(2);
RegLine_DFA=model(Poly_DFA,log10(scale_DFA),order);


 if(AFA==1)
   [scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA] =AFA_basic(signal,q,order);
%% FIGURE 1 : PLOT IF AFA ==1 the slope withe the coefficient alpha 
    Poly_AFA=reg_lin(log10(scale_AFA),log10(F_AFA),order);
    Alpha_AFA=Poly_AFA(2);
    RegLine_AFA=model(Poly_AFA,log10(scale_AFA),order);
% %     figure(7)
%     scatter(log10(scale_AFA),log10(F_AFA));
%     hold on
%     plot(log10(scale_AFA),RegLine_AFA);
%     %axis([min(log10(scale_AFA)) max(log10(scale_AFA)) min(RegLine_AFA) max(RegLine_AFA)]);
%     title('Determination du coefficient Alpha par AFA');
%     xlabel('logn');ylabel('Fn');

%% FIGURE 2 IF AFA SUBPLOT TO SHOW THE DIFFERENCE 
%   figure,
%   subplot(2,1,1)
%   plot(Signal_int);
%   hold on
%   plot(Signal_DFA_demo)
%   axis([min(absis) max(absis) min(Signal_int) max(Signal_int)]);
%   title('Superposition of the integrated signal and the DFA treatment');
%   xlabel('Samples')
%   ylabel('Value');
%   subplot(2,1,2)
%   plot(Signal_int_AFA);
%   hold on
%   plot(Signal_AFA_demo)
%   axis([min(absis) max(absis) min(Signal_int_AFA) max(Signal_int_AFA)]);
%   title('Superposition of the integrated signal and the AFA treatment');
%   xlabel('Samples');
%   ylabel('Value');
  else if(correction==1)%%terme correctif vaut 1 ( if terme  
     Poly2=reg_lin(log10(scale_DFA),log10(F_DFA_corr),order);
     Alpha_corr=Poly2(2);
     RegLine_corr=model(Poly2,log10(scale_DFA),order);
% %      FIGURE 1 
% %      scatter(log10(scale),log10(F_DFA_corr));
% %      hold on
% %      plot(log10(scale),RegLine_corr);
% %      title('DFA with correction function');
%%       str_corr={'Alpha=',num2str(Alpha_corr)}
% %      xlabel('logn');
% %       ylabel('Fn'); text(2,0.15,str_corr)
% %%     FIGURE 2 
% %%FOR FIGURE 2 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
% % figure,
% % absis=(1:length(Signal_DFA_R));
% % plot(Signal);
% % 
% % %% to appear the line for windows that have been cut 
% % % for kk=1:length(Signal_advanced)
% % %     if(mod(kk,display)==0)
% % %         test(1,kk)=300;
% % %     else
% % %         test(1,kk)=min(Signal)-15;
% % %      end
% % % end
% % % hold on
% % % plot(test)
% % 
% % hold on
% % plot(Signal_DFA_R)
% % axis([min(absis) max(absis) min(Signal) max(Signal)]);
% % title('Superposition of the integrated signal and the DFA treatment');
% % xlabel('Samples');
% % ylabel('Value');
% 
% 
% %%FOR FIGURE 3 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
% % N=2048;
% % f=(-1/2:1/N:1/2-1/N);
% % X = fftshift(abs(fft(signal,N))); 
% % subplot(1,2,2)
% % plot(f,X);
% % axis([min(f) max(f) min(X) max(X) ]);
% % title('Signal Spectrum');
% % xlabel('Frequences')
% 
%       
  end
   
end






end

