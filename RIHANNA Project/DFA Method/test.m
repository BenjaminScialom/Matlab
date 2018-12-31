clc, close all, clear all;
load('WEI_15.mat');
M = load('WEI_15.mat');

signal = WEI_7_1(1:1000);

%signal = randn(1,1024);
alpha1 = DFA_basic(signal',1);
alpha2 = LR_DFA(signal',1);
