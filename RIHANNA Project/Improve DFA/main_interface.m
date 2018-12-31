clear all; close all ; clc 
%%Variable that the interface gathered
% load('WEI_15');
signal = randn(1,1024); % data
Advanced=0;
frame=(10:length(signal)/4);
N_display=10;
%%the following parameters will have an impact only if Advanced= 1 
order = 1; % order of linear regression order=[1:3]
q = 2; % mono(2) or multi fractal q=[2:6]
AFA = 1; % if computation of AFA
backward=1;
correction=1;
if(correction==1)
    AFA=0;
end
[scale_advanced,RegLine_advanced,F_DFA_advanced,Alpha_advanced ,Signal_DFA_R_advanced,Signal_advanced,scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA,Alpha_AFA,RegLine_AFA,scale_DFA, F_DFA,F_DFA_corr,Signal_DFA_R,Signal,Alpha_DFA,RegLine_DFA,RegLine_corr,Alpha_corr] = DFA_Interface(signal,Advanced,N_display,backward,q,correction,AFA,order,frame);

if(Advanced==0)
    %%FIGURE 1 : 
    % figure,SLOPE COPY THE FOLLOWING CODE IN ORDER TO PLOT THE 1 FIGURE  
    scatter(log10(scale_advanced),log10(F_DFA_advanced)); %fitting points figure
    hold on
    plot(log10(scale_advanced),RegLine_advanced);
    axis([min(log10(scale_advanced)) max(log10(scale_advanced)) min(RegLine_advanced) max(RegLine_advanced)]);
    title('Determination of the coefficient Alpha by DFA');
    str={'Alpha',num2str(Alpha_advanced)};
    xlabel('logn');ylabel('Fn');text(2,0.3,str);

    %FOR FIGURE 2 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
    figure,
    absis=(1:length(Signal_DFA_R_advanced));
    plot(Signal_advanced);

    %% to appear the line for windows that have been cut 
    % for kk=1:length(Signal_advanced)
    %     if(mod(kk,display)==0)
    %         test(1,kk)=300;
    % %     else
    % %         test(1,kk)=min(Signal)-15;
    % %      end
    % % end
    % % hold on
    % % plot(test)
    % 
    hold on
    plot(Signal_DFA_R_advanced)
    axis([min(absis) max(absis) min(Signal_advanced) max(Signal_advanced)]);
    title('Superposition of the integrated signal and the DFA treatment');
    xlabel('Samples');
    ylabel('Value');


    %FOR FIGURE 3 COPY THE CODE IN ORDER TO PLOT FIGURE 3 
    N=2048;
    f=(-0.1:1/N:0.1-1/N);
    X = fftshift(abs(fft(Signal_advanced,floor(N/5)))); 
    figure
    plot(f,X);
%     axis([min(f) max(f) min(X) max(X) ]);
    title('Signal Spectrum');
    xlabel('Frequences')
else
    if(AFA==1)
        %%1subplot
        figure,
        subplot(2,1,1)
        plot(Signal);
        hold on
        plot(Signal_DFA_R)
        %axis([min(absis) max(absis) min(Signal) max(Signal)]);
        title('Superposition of the integrated signal and the DFA treatment');
        xlabel('Samples')
        ylabel('Value');
        subplot(2,1,2)
        plot(Signal_int_AFA);
        hold on
        plot(Signal_AFA_demo)
        %axis([min(absis) max(absis) min(Signal_int_AFA) max(Signal_int_AFA)]);
        title('Superposition of the integrated signal and the AFA treatment');
        xlabel('Samples');
        ylabel('Value');
        %%pente 
        figure,
        scatter(log10(scale_AFA),log10(F_AFA));
        hold on
        plot(log10(scale_AFA),RegLine_AFA);
        %axis([min(log10(scale_AFA)) max(log10(scale_AFA)) min(RegLine_AFA) max(RegLine_AFA)]);
        title('Determination of the coefficient Alpha by AFA');
        str={'Alpha',num2str(Alpha_AFA)};
        xlabel('logn');ylabel('Fn');text(2,0.1,str)
        %%Figure 3 
        N=2048;
        f=(-0.1:1/N:0.1-1/N);
        X = fftshift(abs(fft(Signal,floor(N/5)))); 
        figure
        subplot(1,2,1)
        plot(f,X);
        %axis([min(f) max(f) min(X) max(X) ]);
        hold on
        Y=fftshift(abs(fft(Signal_AFA_demo,floor(N/5))))
        plot(f,Y);
        title('Spectrum with AFA treatement');
        xlabel('Frequences')
        legend('Signal Spectrum','Signal Spectrum with AFA')
        subplot(1,2,2)
        plot(f,X);
        hold on
        Z=fftshift(abs(fft(Signal_DFA_R,floor(N/5))))
        plot(f,Z);
        title('Spectrum with DFA treatement');
        xlabel('Frequences')
        legend('Signal Spectrum','Signal Spectrum with DFA')

    elseif(correction==1)
        %%1 subpplot  pente + recons
        
        % %      FIGURE 1 pente
         subplot(1,2,1)
         scatter(log10(scale_DFA),log10(F_DFA_corr));
         hold on
         plot(log10(scale_DFA),RegLine_corr);
         title('DFA with correction function');
         str_corr={'Alpha=',num2str(Alpha_corr)}
         xlabel('logn');ylabel('Fn'); text(2,0.15,str_corr)
         subplot(1,2,2)
         scatter(log10(scale_DFA),log10(F_DFA));
         hold on
         plot(log10(scale_DFA),RegLine_DFA);
         title('DFA without correction function');
         str_corr={'Alpha=',num2str(Alpha_DFA)}
         xlabel('logn');ylabel('Fn'); text(2,0.15,str_corr)
         
         %%FIGURE 2 
         figure,
         absis=(1:length(Signal_DFA_R));
         plot(Signal);

        %% to appear the line for windows that have been cut 
        % for kk=1:length(Signal_advanced)
        %     if(mod(kk,display)==0)
        %         test(1,kk)=300;
        %     else
        %         test(1,kk)=min(Signal)-15;
        %      end
        % end
        % hold on
        % plot(test)

        hold on
        plot(Signal_DFA_R)
        axis([min(absis) max(absis) min(Signal) max(Signal)]);
        title('Superposition of the integrated signal and the DFA treatment');
        xlabel('Samples');
        ylabel('Value');
        
    else
        %%FIGURE 1 
        scatter(log10(scale_DFA),log10(F_DFA));
        hold on
        plot(log10(scale_DFA),RegLine_DFA);
        title('DFA without correction function');
        str_corr={'Alpha=',num2str(Alpha_DFA)}
        xlabel('logn');ylabel('Fn'); text(2,0.15,str_corr)
        %%FIGURE 2 
        figure,
        plot(Signal);
        hold on
        plot(Signal_DFA_R)
        %axis([min(absis) max(absis) min(Signal) max(Signal)]);
        title('Superposition of the integrated signal and the DFA treatment');
        xlabel('Samples')
        ylabel('Value');
        %%FIGURE 3 
        N=2048;
        f=(-1/2:1/N:1/2-1/N);
        X = fftshift(abs(fft(Signal,N))); 
        figure
        plot(f,X);
%         axis([min(f) max(f) min(X) max(X) ]);
        title('Signal Spectrum');
        xlabel('Frequences')
    end
    
end