% clear all, clc, close all;

%% This the main of DFA method
%% Noemie Cohen && Axelle Weber

%% INPUTS


% signal = randn(1,1024); % data

% o = importdata('gait-data/o3-75-si.txt');
% signal_o = o(:, 2);
% y = importdata('gait-data/y2-29-si.txt');
% signal_y = y(:, 2);
% pd = importdata('gait-data/pd5-si.txt');
% signal_pd = pd(:, 2);
% figure,
% % subplot(2,1,1)
% plot(signal_y),
% hold on,
% % subplot(2,1,2),
% plot(signal_o);
% % hold on,
% plot(signal_pd);
% absis = (1:length(signal_pd));
% % axis([min(absis) max(absis) min(signal_pd) max(signal_pd)])
% legend('young','old','parkison disease');
% hold off;
% % 
% % figure, 
% % plot(xcorr(signal_o));
figure,
plot(signal);

% signal = signal_o;
order = 1; % order of linear regression order=[1:3]
q = 2; % mono(2) or multi fractal q=[2:6]
correction = 0; % if K_correction : average on <correction_number> number (1 for un-modified DFA)
AFA = 0; % if computation of AFA
forward = 1;

%% Windows
max = floor(length(signal)*0.1); %régularité des points sur log log Goldberger
frame = (4:max);
N_display = 4;

%% DFA COMPUTATION
tic
[~, F_DFA, F_DFA_corr,~,~] =  DFA_basic(signal,q,order,correction,N_display,forward,frame);
toc
%% AFA COMPUTATION
tic
if AFA == 1
[frame_AFA , F_AFA,~,~] =  AFA_basic(signal,q,order);
end
toc
 
 
%% OUTPUTS

%% DFA
Poly=reg_lin(log10(frame),log10(F_DFA),order);
Alpha=Poly(2);
RegLine=model(Poly,log10(frame),order);
figure,
scatter(log10(frame),log10(F_DFA)); %fitting points figure
hold on
plot(log10(frame),RegLine);
%axis([min(log10(frame)) max(log10(frame)) min(RegLine) max(RegLine)]);
title('Determination du coefficient Alpha par DFA');
xlabel('logn');ylabel('Fn');

%% AFA
if AFA == 1
    Poly_AFA=reg_lin(log10(frame_AFA),log10(F_AFA),order);
    Alpha_AFA=Poly_AFA(2);
    RegLine_AFA=model(Poly_AFA,log10(frame_AFA),order);
    figure(7)
    scatter(log10(frame_AFA),log10(F_AFA));
    hold on
    plot(log10(frame_AFA),RegLine_AFA);
    %axis([min(log10(frame_AFA)) max(log10(frame_AFA)) min(RegLine_AFA) max(RegLine_AFA)]);
    title('Determination du coefficient Alpha par AFA');
    xlabel('logn');ylabel('Fn');

end

%% Modified DFA
if correction == 1 && Alpha < 1 
  Poly2=reg_lin(log10(frame),log10(F_DFA_corr),order);
  Alpha_corr=Poly2(2);
  RegLine2=model(Poly2,log10(frame),order);
  figure(8),
  scatter(log10(frame),log10((F_DFA_corr)));
  hold on
  plot(log10(frame),RegLine2);
  %axis([min(log10(frame)) max(log10(frame)) min(RegLine2) max(RegLine2)]);
  title('Determination du coefficient Alpha by the correction DFA');
  xlabel('logn');ylabel('Fn');
end


