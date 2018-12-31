function INTERFACE2

close all
%%  Create and then hide the GUI as it is being constructed.

f = figure('Visible','off','Position',[100,800,1000,800]);

%% Variable initialization

data = 0;
val=1;
% Variable DFA
val_DFA=1;
length='';
data_length=0;
val_option_DFA=0;
correction=0;
op_AFA=0;
forward=1;
% Variable Power Analysis (PA)
val_PA=0;


%% signal pannel components

fpanel_Signal = uipanel('Title','Signal','FontSize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.8 0.98 0.2]);

Axes_signal = axes('parent',fpanel_Signal,'Position',[0.25 0.2 0.7 0.75]);


artefac_choice = uicontrol('parent',fpanel_Signal,'Style','popupmenu',...
    'String',{'with artefac','without artefac',},...
    'Position',[25,40,100,40],...
    'Callback',@artefac_Callback);

signal_choice = uicontrol('parent',fpanel_Signal,'Style','pushbutton','String','Select Data',...
    'Position',[25,90,100,40],...
    'Callback',@signal_choice_Callback);

signal_plot = uicontrol('parent',fpanel_Signal,'Style','pushbutton','String','Plot','Tag','plot_signal',...
    'Position',[25,10,100,40],...
    'Callback',@signal_plot_Callback);

lambda_input = uicontrol('parent',fpanel_Signal,'Style','edit','String','lambda','Tag','lambda_value',...
    'Position',[135,50,100,40],...
    'Callback',@lambda_input_Callback);


%% Methodes Panel components

fpanel_Methodes = uipanel('Title','Analysis','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.98 0.8]);

% Creation of the pannel group (des onglets)

tabgp = uitabgroup(fpanel_Methodes,'units','normalized','Position',[.01 .01 .98 .98]);
tab1 = uitab(tabgp,'Title','EMD','ButtonDownFcn',@emd_callback);
tab2 = uitab(tabgp,'Title','DFA');
tab3 = uitab(tabgp,'Title','MSE');
tab4 = uitab(tabgp,'Title','Power Analysis');

% Empirical Mode Decomposition Method components

Display_EMD_panel = uipanel('parent',tab1,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.98 0.98]);

Axes_EMD = axes('parent',Display_EMD_panel,'Position',[0.1 0.1 0.5 0.8],'visible','off');

hemd = uicontrol('parent',Display_EMD_panel,'Style','pushbutton','String','EMD',...
          'Units','normalized','Position',[0,0.002,0.1,0.05],...
          'Callback',@emd_callback);
      
hemd_spectro = uicontrol('parent',Display_EMD_panel,'Style','pushbutton','String','Spectrograms',...
  'Units','normalized','Position',[0.1,0.002,0.1,0.05],...
  'Callback',@spec_emd_callback);

hemd_display = uicontrol('parent',Display_EMD_panel,'Style','pushbutton','String','Display Decomposition',...
  'Units','normalized','Position',[0.2,0.002,0.1,0.05],...
  'Callback',@display_emd_callback);

% Detrended Fluctuation Analysis Metod components

Data_DFA_panel = uipanel('parent',tab2,'Title','Data','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.3 0.99]);

text_DFA_Mode = uicontrol('Parent',Data_DFA_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Please choose your mode','Tag','txt_dfa_mode',...
    'Position',[0.1 0.9 0.85 0.1]);

mode_DFA_choice = uicontrol('parent',Data_DFA_panel,'Style','popupmenu',...
    'String',{'Non-Advanced','Advanced',},'Units','normalized',...
    'Position',[0.3 0.86 0.5 0.1],'Tag','choice_dfa_mode',...
    'Callback',@mode_DFA_Callback);

text_DFA_Frame = uicontrol('Parent',Data_DFA_panel,'Style','text','BackgroundColor','white','Units','normalized','Tag','txt_frame',...
    'String','Please enter the frame length before running (it should be less than the signal length divided by 2):',...
    'Position',[0.1 0.7 0.85 0.2]);

window_DFA_value = uicontrol('parent',Data_DFA_panel,'Style','edit','String','window','Tag','window_value','Units','normalized',...
    'Position',[0.3 0.75 0.4 0.05],...
    'Callback',@window_DFA_input_Callback);

Frame_DFA_value = uicontrol('parent',Data_DFA_panel,'Style','edit','String','Frame','Tag','Frame_value','Units','normalized',...
    'Position',[0.3 0.67 0.4 0.05],...
    'Callback',@Frame_DFA_input_Callback);

text_DFA_q = uicontrol('Parent',Data_DFA_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Please enter the order of the multi-fractal DFA, it is between 2 and 6:','Tag','txt_q_value',...
    'Position',[0.1 0.5 0.8 0.1]);

q_value_DFA = uicontrol('parent',Data_DFA_panel,'Style','edit','String','2','Tag','q_value','Units','normalized',...
    'Position',[0.3 0.47 0.5 0.05],...
    'Callback',@q_DFA_input_Callback);

direction_DFA_choice = uicontrol('parent',Data_DFA_panel,'Style','popupmenu',...
    'String',{'Forward & Backward','Backward',},'Units','normalized','Tag','direction_choice',...
    'Position',[0.3 0.33 0.5 0.1],...
    'Callback',@direction_DFA_Callback);

option_DFA_choice = uicontrol('parent',Data_DFA_panel,'Style','popupmenu',...
    'String',{'None','Correction','AFA'},'Units','normalized','Tag','option_choice',...
    'Position',[0.3 0.25 0.5 0.1],...
    'Callback',@option_DFA_Callback);

text_DFA_order = uicontrol('Parent',Data_DFA_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Please enter an order between 1 and 3 :','Tag','txt_order_value',...
    'Position',[0.1 0.18 0.8 0.1]);

order_value_DFA = uicontrol('parent',Data_DFA_panel,'Style','edit','String','1','Tag','order_value','Units','normalized',...
    'Position',[0.3 0.18 0.5 0.05],'Tag','order_value',...
    'Callback',@order_DFA_input_Callback);

DFA_plot = uicontrol('parent',Data_DFA_panel,'Style','pushbutton','String','Plot','Tag','plot_dfa','Units','normalized',...
    'Position',[0.3 0.05 0.5 0.1],...
    'Callback',@DFA_plot_Callback);


Display_DFA_panel = uipanel('parent',tab2,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.3 0.01 0.7 0.99]);

axes_Reg_DFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Reg',...
             'Position', [0.1 0.1 0.3 .3]);         
         
axes_spectre_DFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Spec',...
             'Position', [0.6 0.1 0.3 .3]);
         
axes_window_DFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Win',...
             'Position', [0.1 0.6 0.8 .35]);

axes_Reg_DFA_Advanced_none = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Reg_Advanced_none',...
             'Position', [0.1 0.1 0.3 .3]);         
         
axes_spectre_DFA_Advanced_none = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Spec_Advanced_none',...
             'Position', [0.6 0.1 0.3 .3]);
         
axes_window_DFA_Advanced_none = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Win_Advanced_none',...
             'Position', [0.1 0.6 0.8 .35]);

axes_Reg_DFA_Advanced_corr = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Reg_Advanced_corr',...
             'Position', [0.1 0.1 0.3 .3]);         
         
axes_spectre_DFA_Advanced_corr = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Spec_Advanced_corr',...
             'Position', [0.6 0.1 0.3 .3]);
         
axes_Reg_DFA_Advanced_AFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Reg_Advanced_AFA',...
             'Position', [0.1 0.1 0.3 .3]);         
         
axes_spectre_DFA_Advanced_AFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Spec_Advanced_AFA',...
             'Position', [0.6 0.1 0.3 .3]);
         
axes_window_DFA_Advanced_AFA = axes('Parent',Display_DFA_panel,'Units', 'normalized','Tag','axes_Win_Advanced_AFA',...
             'Position', [0.1 0.6 0.8 .35]);
         
% Multi-Scale entropy Method components

Data_MSE_panel = uipanel('parent',tab3,'Title','Data','Fontsize',12,...
     'BackgroundColor','white',...
     'Position',[0.01 0.01 0.2 0.98]);

Display_MSE_panel = uipanel('parent',tab3,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.2 0.01 0.8 0.98]);


mse_plot = uicontrol('parent',Data_MSE_panel,'Style','pushbutton','String','Plot','Tag','plot_mse','Units','normalized',...
    'Position',[0.2 0.2 0.5 0.15],...
    'Callback',@mse_plot_Callback);

max_scale_mse_input = uicontrol('parent',Data_MSE_panel,'Style','edit','String','Max Scale','Tag','max_scale_mse_value','Units','normalized',...
    'Position',[0.2 0.8 0.5 0.15],...
    'Callback',@max_scale_mse_input_Callback);

m_mse_input = uicontrol('parent',Data_MSE_panel,'Style','edit','String','m','Tag','m_mse_value','Units','normalized',...
    'Position',[0.2 0.6 0.5 0.15],...
    'Callback',@m_mse_input_Callback);

r_mse_input = uicontrol('parent',Data_MSE_panel,'Style','edit','String','r','Tag','r_mse_value','Units','normalized',...
    'Position',[0.2 0.4 0.5 0.15],...
    'Callback',@r_mse_input_Callback);

axes_mse = axes('Parent',Display_MSE_panel,'Units', 'normalized','Tag','axes_MSE',...
             'Position', [0.1 0.1 .8 .8]);
         

% Detrended Fluctuation Analysis Method components

Data_Power_Analysis_panel = uipanel('parent',tab4,'Title','Data','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.2 0.99]);

text_PA_Mode = uicontrol('Parent',Data_Power_Analysis_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Please choose your mode','Tag','txt_PA_mode',...
    'Position',[0.1 0.9 0.85 0.1]);

mode_PA_choice = uicontrol('parent',Data_Power_Analysis_panel,'Style','popupmenu',...
    'String',{'FFT','AR Model',},'Units','normalized',...
    'Position',[0.3 0.85 0.5 0.1],'Tag','choice_PA_mode',...
    'Callback',@mode_PA_Callback);

text_order_max_PA = uicontrol('Parent',Data_Power_Analysis_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','How many order do you want to display ?','Tag','txt_order',...
    'Position',[0.1 0.82 0.85 0.07]);

order_max_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','Max Order','Tag','order_PA_value','Units','normalized',...
    'Position',[0.3 0.77 0.5 0.05],...
    'Callback',@order_max_PA_input_Callback);

PA_plot_variance = uicontrol('parent',Data_Power_Analysis_panel,'Style','pushbutton','String','Plot variance','Tag','plot_var','Units','normalized',...
    'Position',[0.3 0.65 0.5 0.1],...
    'Callback',@PA_plot_variance_Callback);

text_order_choosen_PA = uicontrol('Parent',Data_Power_Analysis_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Order Choosen','Tag','txt_order_choosen',...
    'Position',[0.1 0.58 0.85 0.05]);

order_choosen_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','Choosen Order','Tag','order_PA_value_choosen','Units','normalized',...
    'Position',[0.3 0.55 0.5 0.05],...
    'Callback',@order_choosen_input_Callback);

text_global_value_PA = uicontrol('Parent',Data_Power_Analysis_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','DSP and FFT parameters','Tag','txt_global_value_PA',...
    'Position',[0.1 0.47 0.85 0.05]);

fmin_value_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','fmin','Tag','fmin_value','Units','normalized',...
    'Position',[0.3 0.43 0.5 0.05],...
    'Callback',@fmin_PA_input_Callback);

fmax_value_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','fmax','Tag','fmax_value','Units','normalized',...
    'Position',[0.3 0.39 0.5 0.05],...
    'Callback',@fmax_PA_input_Callback);

padding_value_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','padding','Tag','padding_value','Units','normalized',...
    'Position',[0.3 0.34 0.5 0.05],...
    'Callback',@padding_PA_input_Callback);

text_periodo_value_PA = uicontrol('Parent',Data_Power_Analysis_panel,'Style','text','BackgroundColor','white','Units','normalized',...
    'String','Periodogram parameters','Tag','txt_global_value_PA',...
    'Position',[0.1 0.23 0.85 0.1]);

window_value_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','window','Tag','window_PA_value','Units','normalized',...
    'Position',[0.3 0.21 0.5 0.05],...
    'Callback',@window_PA_input_Callback);

pas_value_PA = uicontrol('parent',Data_Power_Analysis_panel,'Style','edit','String','pas','Tag','pas_value','Units','normalized',...
    'Position',[0.3 0.16 0.5 0.05],...
    'Callback',@pas_PA_input_Callback);

PA_plot = uicontrol('parent',Data_Power_Analysis_panel,'Style','pushbutton','String','Plot','Tag','plot_PA','Units','normalized',...
    'Position',[0.3 0.05 0.5 0.1],...
    'Callback',@PA_plot_Callback);



Display_Power_Analysis_panel = uipanel('parent',tab4,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.2 0.01 0.8 0.99]);

axes_dsp = axes('Parent',Display_Power_Analysis_panel,'Units', 'normalized','Tag','axes_DSP',...
             'Position', [0.1 0.55 0.8 0.4]);

axes_perio_rect = axes('Parent',Display_Power_Analysis_panel,'Units', 'normalized','Tag','axes_rect',...
             'Position', [0.1 0.1 0.4 .3]);

axes_perio_trap = axes('Parent',Display_Power_Analysis_panel,'Units', 'normalized','Tag','axes_trap',...
             'Position', [0.55 0.1 0.4 .3]);
         
axes_variance = axes('Parent',Display_Power_Analysis_panel,'Units', 'normalized','Tag','axes_var',...
             'Position', [0.55 0.1 0.4 .3]);
         
axes_dsp2 = axes('Parent',Display_Power_Analysis_panel,'Units', 'normalized','Tag','axes_DSP2',...
             'Position', [0.55 0.55 0.4 0.4]);
         
         
%% Global display option

% Assign the GUI a name to appear in the window title.
f.Name = 'RIHANNA Interface';
% Move the GUI to the center of the screen.
movegui(f,'center')
f.Visible = 'on';% Make the GUI visible.
lambda_input.Visible = 'off';

% MSE
axes_mse.Visible='off';
title(axes_mse, 'Multiscale Entropy')  
hold(axes_mse, 'all')

% DFA
axes_window_DFA.Visible='off';
axes_spectre_DFA.Visible='off';
axes_Reg_DFA.Visible='off';
axes_Reg_DFA_Advanced_none.Visible='off';
axes_spectre_DFA_Advanced_none.Visible='off';
axes_window_DFA_Advanced_none.Visible='off';
axes_Reg_DFA_Advanced_corr.Visible='off';
axes_spectre_DFA_Advanced_corr.Visible='off';
axes_Reg_DFA_Advanced_AFA.Visible='off';
axes_spectre_DFA_Advanced_AFA.Visible='off';
axes_window_DFA_Advanced_AFA.Visible='off';
text_DFA_Frame.Visible='off';
text_DFA_q.Visible='off';
Frame_DFA_value.Visible='off';
window_DFA_value.Visible='off';
DFA_plot.Visible='off';
q_value_DFA.Visible='off';
direction_DFA_choice.Visible='off';
option_DFA_choice.Visible='off';
order_value_DFA.Visible='off';
text_DFA_order.Visible='off';

% Power Analysis
text_global_value_PA.Visible='off';
fmin_value_PA.Visible='off';
fmax_value_PA.Visible='off';
padding_value_PA.Visible='off';
text_periodo_value_PA.Visible='off';
window_value_PA.Visible='off';
pas_value_PA.Visible='off';
PA_plot.Visible='off';
text_order_max_PA.Visible='off';
order_max_PA.Visible='off';
axes_dsp.Visible='off';
axes_perio_rect.Visible='off';
axes_perio_trap.Visible='off';
axes_variance.Visible='off';
axes_dsp2.Visible='off';
text_order_choosen_PA.Visible='off';
order_choosen_PA.Visible='off';
PA_plot_variance.Visible='off';
%% Callbacks

%     Callbacks for INTERFACE. These callbacks automatically
%     have access to component handles and initialized data
%     because they are nested at a lower level.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     Pop-up menu callback. Read the pop-up menu Value property
%     to determine if the plot is with or without artefac.
    function artefac_Callback(source,~,~)
        % Determine the selected data set.
        str = source.String;
        val = source.Value;
        % Set current data to the selected data set.
        switch str{val} 
           case 'with artefac' 
               set(findobj(lambda_input,'Tag','lambda_value'),'Visible','off');
           case 'without artefac' 
               set(findobj(lambda_input,'Tag','lambda_value'),'Visible','on');
        end
    end

    % Push button for the selection of data callbacks.
    function signal_choice_Callback(~,~,~)
        
        [filename, ~] = uigetfile('*.mat', 'Select a MATLAB code file');
        if isequal(filename,0)
            disp('User selected Cancel')
        else
            disp(['User selected ', fullfile(filename)])
            data = importdata(filename);
            data = data(~isnan(data));           
            data_length=numel(data);
        end     
    end
    
    % Push button plot callback -> Display of the analysed signal with or
    % without artefac -> according to th value of val
    function signal_plot_Callback(~,~,~)
        
        if val==1
            
            data_length=numel(data);
            length=num2str(data_length);
            disp(['The signal length is : ',length])
            plot(Axes_signal,data);
            
        else
            lambda = str2double(get(findobj(lambda_input,'Tag','lambda_value'),'String'));
            Tfilt = Filtre_Tarvainen(data,lambda);
            plot(Axes_signal,data)
            hold(Axes_signal, 'all')
            plot(Axes_signal,data-Tfilt, 'r-')
            data = data-Tfilt;
            data_length=numel(data);
            length = num2str(data_length); 
            
            
        end
        
    end

    % Edit Box call back -> take and set lambda value here
    function lambda_input_Callback(~, ~, ~)


        % Validate that the text in the f1 field converts to a real number
        lambda = str2double(get(findobj(lambda_input,'Tag','lambda_value'),'String')); 
        if isnan(lambda) || ~isreal(lambda)  
        % Disable the Plot button and change its string to say why 
        set(findobj(signal_plot,'Tag','plot_signal'),'String','Cannot plot f1')
        set(findobj(signal_plot,'Tag','plot_signal'),'Enable','off')      
        else 
        % Enable the Plot button with its original name      
        set(findobj(signal_plot,'Tag','plot_signal'),'String','Plot')
        set(findobj(signal_plot,'Tag','plot_signal'),'Enable','on')
        end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    function emd_callback(~,~,~)
        IMF = emd(data);
        n = size(IMF,1);
        for i = 1 : n
          subplot(n,1,i,'Parent', Display_EMD_panel);
          plot(IMF(i,:))  
        end
    end

    function spec_emd_callback(~,~,~)   
        IMF = emd(data);
        n = size(IMF,1);
        for i = 1 : n
            subplot(n,1,i,'Parent', Display_EMD_panel);
            spectrogram(IMF(i,:))  
        end
    view([-90 90])
    end

    function display_emd_callback(~,~,~)
        
        IMF = emd(data,'display',1);
        n = size(IMF,1);

        for i = 1 : n          
           subplot(n,1,i,'Parent', Display_EMD_panel);
           plot(IMF(i,:))           
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    function mse_plot_Callback(~,~,~)
        
        set(findobj(axes_mse,'Tag','axes_MSE'),'Visible','on');
        
        max_scale_mse = str2double(get(findobj(max_scale_mse_input,'Tag','max_scale_mse_value'),'String'));
        m_mse = str2double(get(findobj(m_mse_input,'Tag','m_mse_value'),'String'));
        r_mse = str2double(get(findobj(r_mse_input,'Tag','r_mse_value'),'String'));
        [Area,SampEn]=multise(data,max_scale_mse,m_mse,r_mse);
        plot(axes_mse,1:max_scale_mse,SampEn)
        xlabel('scale')
        ylabel('SampEn')
        title('Multi-Sclae Entropy');
        strmse={'Area',num2str(Area)};
        text(axes_mse,max_scale_mse-1,max(SampEn),strmse);
        
    end

    
    function max_scale_mse_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        max_scale_mse = str2double(get(findobj(max_scale_mse_input,'Tag','max_scale_mse_value'),'String'));
        if isnan(max_scale_mse) || ~isreal(max_scale_mse)  
        % Disable the Plot button and change its string to say why 
        set(findobj(mse_plot,'Tag','plot_signal'),'String','max scale invalid')
        set(findobj(mse_plot,'Tag','plot_signal'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(mse_plot,'Tag','plot_signal'),'String','Plot')
        set(findobj(mse_plot,'Tag','plot_signal'),'Enable','on')
        end
    end

    function m_mse_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        m_mse = str2double(get(findobj(m_mse_input,'Tag','m_mse_value'),'String'));
        if isnan(m_mse) || ~isreal(m_mse)  
        % Disable the Plot button and change its string to say why 
        set(findobj(mse_plot,'Tag','plot_mse'),'String','m invalid')
        set(findobj(mse_plot,'Tag','plot_mse'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(mse_plot,'Tag','plot_mse'),'String','Plot')
        set(findobj(mse_plot,'Tag','plot_mse'),'Enable','on')
        end
    end

    function r_mse_input_Callback(~, ~, ~)
        
        set(findobj(axes_mse,'Tag','lambda_value'),'Visible','off');

        % Validate that the text in the edit text field converts to a real number
        r_mse = str2double(get(findobj(r_mse_input,'Tag','r_mse_value'),'String'));
        if isnan(r_mse) || ~isreal(r_mse)  
        % Disable the Plot button and change its string to say why 
        set(findobj(mse_plot,'Tag','plot_mse'),'String','r invalid')
        set(findobj(mse_plot,'Tag','plot_mse'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(mse_plot,'Tag','plot_mse'),'String','Plot')
        set(findobj(mse_plot,'Tag','plot_mse'),'Enable','on')
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    function mode_DFA_Callback(source2,~,~)
        % Determine the selected data set.
        str_DFA = source2.String;
        val_DFA = source2.Value;
        % Set current data to the selected data set.
        switch str_DFA{val_DFA}
                  
           case 'Non-Advanced' 
                
                set(findobj(mode_DFA_choice,'Tag','choice_PA_mode'),'Visible','off');
                set(findobj(q_value_DFA,'Tag','q_value'),'Visible','off');
                set(findobj(direction_DFA_choice,'Tag','direction_choice'),'Visible','off');
                set(findobj(option_DFA_choice,'Tag','option_choice'),'Visible','off');
                set(findobj(order_value_DFA,'Tag','order_value'),'Visible','off'); 
                set(findobj(Frame_DFA_value,'Tag','Frame_value'),'Visible','off');
                set(findobj(text_DFA_order,'Tag','txt_order_value'),'Visible','off');
                set(findobj(text_DFA_q,'Tag','txt_q_value'),'Visible','off');
                set(findobj(text_DFA_Frame,'Tag','txt_frame'),'Visible','on');
                set(findobj(window_DFA_value,'Tag','window_value'),'Visible','on');
                set(findobj(DFA_plot,'Tag','plot_dfa'),'Visible','on');
                
           case 'Advanced' 
                
                set(findobj(text_DFA_Frame,'Tag','txt_frame'),'Visible','on');
                set(findobj(window_DFA_value,'Tag','window_value'),'Visible','on');
                set(findobj(Frame_DFA_value,'Tag','Frame_value'),'Visible','on');
                set(findobj(text_DFA_q,'Tag','txt_q_value'),'Visible','on');
                set(findobj(q_value_DFA,'Tag','q_value'),'Visible','on');
                set(findobj(direction_DFA_choice,'Tag','direction_choice'),'Visible','on');
                set(findobj(option_DFA_choice,'Tag','option_choice'),'Visible','on');
                set(findobj(text_DFA_order,'Tag','txt_order_value'),'Visible','on');
                set(findobj(order_value_DFA,'Tag','order_value'),'Visible','on');
                set(findobj(DFA_plot,'Tag','plot_dfa'),'Visible','on');
        end 
    end

    function window_DFA_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        N_DFA = str2double(get(findobj(window_DFA_value,'Tag','window_value'),'String'));
        if isnan(N_DFA) || ~isreal(N_DFA) || N_DFA>numel(data)/2
            % Disable the Plot button and change its string to say why
            set(findobj(DFA_plot,'Tag','plot_mse'),'String','N invalid')
            set(findobj(DFA_plot,'Tag','plot_mse'),'Enable','off')
        else 
            % Enable the Plot button with its original name      
            set(findobj(DFA_plot,'Tag','plot_mse'),'String','Plot')
            set(findobj(DFA_plot,'Tag','plot_mse'),'Enable','on')
        end
    end

    function DFA_plot_Callback(~,~,~)
        

        
        if val_DFA==1
            
            

            
            set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','off');
            
            set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_corr'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_corr'),'Visible','off');
             
            set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Reg_Advanced_none'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','off');
            
            set(findobj(axes_Reg_DFA,'Tag','axes_Reg'),'Visible','on');
            set(findobj(axes_spectre_DFA,'Tag','axes_Spec'),'Visible','on');
            set(findobj(axes_window_DFA,'Tag','axes_Win'),'Visible','on');
            
            N_DFA = str2double(get(findobj(window_DFA_value,'Tag','window_value'),'String'));
            max = floor(length(data)/4); 
            frame = (10:max);
            q=2;
            correction=0;
            order=1;
            forward=1;

            [scale_advanced, F_DFA_advanced,~,Signal_DFA_R_advanced,Signal_advanced] =  DFA_basic(data,q,order,correction,N_DFA,forward,frame);

            Poly=reg_lin(log10(scale_advanced),log10(F_DFA_advanced),order);
            Alpha_advanced=Poly(2);
            RegLine_advanced=model(Poly,log10(scale_advanced),order);


            scatter(axes_Reg_DFA,log10(scale_advanced),log10(F_DFA_advanced)); %fitting points figure
            hold(axes_Reg_DFA,'all')
            plot(axes_Reg_DFA,log10(scale_advanced),RegLine_advanced);
            title(axes_Reg_DFA,'Determination of the coefficient Alpha by DFA');
            xlabel(axes_Reg_DFA,'logn');ylabel(axes_Reg_DFA,'Fn');
            alpha_value={'Alpha',num2str(Alpha_advanced)};
            text(axes_Reg_DFA,2.5,0.2,alpha_value);


            % absis=(1:length(Signal_DFA_R_advanced));
            plot(axes_window_DFA,Signal_advanced);
            % to appear the line for windows that have been cut
            hold(axes_window_DFA,'all')
            plot(axes_window_DFA,Signal_DFA_R_advanced)
            title(axes_window_DFA,'Superposition of the integrated signal and the DFA treatment');
            xlabel(axes_window_DFA,'Samples');
            ylabel(axes_window_DFA,'Value');

            Nfft=2048;
            f_fft=(-1/2:1/Nfft:1/2-1/Nfft);
            X = fftshift(abs(fft(data,Nfft))); 
            plot(axes_spectre_DFA,f_fft,X);
            title(axes_spectre_DFA,'Signal Spectrum');
            xlabel(axes_spectre_DFA,'Frequences')
        
        else
         
        q = str2double(get(findobj(q_value_DFA,'Tag','q_value'),'String')); 
        order = str2double(get(findobj(order_value_DFA,'Tag','order_value'),'String'));
        N_DFA = str2double(get(findobj(window_DFA_value,'Tag','window_value'),'String'));  
        frame = [4:str2double(get(findobj(Frame_DFA_value,'Tag','Frame_value'),'String'))];
        
        set(findobj(axes_Reg_DFA,'Tag','axes_Reg'),'Visible','off');
        set(findobj(axes_spectre_DFA,'Tag','axes_Spec'),'Visible','off');
        set(findobj(axes_window_DFA,'Tag','axes_Win'),'Visible','off');
            
            
         if op_AFA == 0 && correction == 0
           
             
            set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','off');
            
            set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_corr'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_corr'),'Visible','off');
             
            set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Reg_Advanced_none'),'Visible','on');
            set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','on');
            set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','on');
             
            [scale_advanced, F_DFA_advanced,~,Signal_DFA_R_advanced,Signal_advanced] =  DFA_basic(data,q,order,correction,N_DFA,forward,frame);
        
            Poly=reg_lin(log10(scale_advanced),log10(F_DFA_advanced),order);
            Alpha_advanced=Poly(2);
            RegLine_advanced=model(Poly,log10(scale_advanced),order);

        
            scatter(axes_Reg_DFA_Advanced_none,log10(scale_advanced),log10(F_DFA_advanced)); %fitting points figure
            hold(axes_Reg_DFA_Advanced_none,'all')
            plot(axes_Reg_DFA_Advanced_none,log10(scale_advanced),RegLine_advanced);
            title('Parent',axes_Reg_DFA_Advanced_none,'Determination of the coefficient Alpha by DFA');
            xlabel('Parent',axes_Reg_DFA_Advanced_none,'logn');ylabel('Parent',axes_Reg_DFA_Advanced_none,'Fn');
            alpha_value2={'Alpha',num2str(Alpha_advanced)};
            text(axes_Reg_DFA_Advanced_none,2.5,0.2,alpha_value2);
        
        
            % absis=(1:length(Signal_DFA_R_advanced));
            plot(axes_window_DFA_Advanced_none,Signal_advanced);
            % to appear the line for windows that have been cut
            hold(axes_window_DFA_Advanced_none,'all')
            plot(axes_window_DFA_Advanced_none,Signal_DFA_R_advanced)
            title('Parent',axes_window_DFA_Advanced_none,'Superposition of the integrated signal and the DFA treatment');
            xlabel('Parent',axes_window_DFA_Advanced_none,'Samples');
            ylabel('Parent',axes_window_DFA_Advanced_none,'Value');
        
            Nfft=2048;
            f_fft=(-1/2:1/Nfft:1/2-1/Nfft);
            X = fftshift(abs(fft(data,Nfft))); 
            subplot(1,2,2)
            plot(axes_spectre_DFA_Advanced_none,f_fft,X);
            title('Parent',axes_spectre_DFA_Advanced_none,'Signal Spectrum');
            xlabel('Parent',axes_spectre_DFA_Advanced_none,'Frequences')    
             
         elseif op_AFA == 0 && correction ==1

            
            set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','off');
            set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Advanced_none'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','off');
            
            set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_cor'),'Visible','on');
            set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_cor'),'Visible','on');
         
            
        
            [scale_advanced, F_DFA_advanced,F_DFA_corr_advanced,~,~] =  DFA_basic(data,q,order,correction,N_DFA,forward,frame);

            Poly_corr=reg_lin(log10(scale_advanced),log10(F_DFA_corr_advanced),order);
            Alpha_corr=Poly_corr(2);
            RegLine_corr=model(Poly_corr,log10(scale_advanced),order);

            Poly=reg_lin(log10(scale_advanced),log10(F_DFA_advanced),order);
            Alpha_advanced=Poly(2);
            RegLine_advanced=model(Poly,log10(scale_advanced),order);


            scatter(axes_Reg_DFA_Advanced_corr,log10(scale_advanced),log10(F_DFA_advanced)); %fitting points figure
            hold(axes_Reg_DFA_Advanced_corr,'all')
            plot(axes_Reg_DFA_Advanced_corr,log10(scale_advanced),RegLine_advanced);
            title('Parent',axes_Reg_DFA_Advanced_corr,'Determination of the coefficient Alpha by DFA');
            xlabel('Parent',axes_Reg_DFA_Advanced_corr,'logn');ylabel('Parent',axes_Reg_DFA_Advanced_corr,'Fn');
            alpha_value={'Alpha',num2str(Alpha_advanced)};
            text(axes_Reg_DFA_Advanced_corr,2.3,0.25,alpha_value);


            scatter(axes_spectre_DFA_Advanced_corr,log10(scale_advanced),log10(F_DFA_corr_advanced)); %fitting points figure
            hold(axes_spectre_DFA_Advanced_corr,'all')
            plot(axes_spectre_DFA_Advanced_corr,log10(scale_advanced),RegLine_corr);
            title('Parent',axes_spectre_DFA_Advanced_corr,'Determination of the coefficient Alpha by DFA with correction');
            xlabel('Parent',axes_spectre_DFA_Advanced_corr,'logn');ylabel('Parent',axes_Reg_DFA_Advanced_corr,'Fn');
            alpha_value_corr={'Alpha',num2str(Alpha_corr)};
            text(axes_spectre_DFA_Advanced_corr,2.3,0.25,alpha_value_corr);
        
         elseif op_AFA == 1 && correction == 0
             

            set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_corr'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_corr'),'Visible','off');
             
            set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Reg_Advanced_none'),'Visible','off');
            set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','off');
            set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','off');            
             
            set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','on');
            set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','on');
            set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','on');
            

             
            [~,~,~,~ ,~,~,scale_AFA, F_AFA,Signal_AFA_demo,Signal_int_AFA,Alpha_AFA,RegLine_AFA,~, ~,~,Signal_DFA_R,Signal,~,~,~,~] = DFA_Interface(data,1,N_DFA,forward,q,correction,op_AFA,order,frame);
            
            

            plot(axes_window_DFA_Advanced_AFA,Signal_int_AFA);
            hold(axes_window_DFA_Advanced_AFA,'all');
            plot(axes_window_DFA_Advanced_AFA,Signal_AFA_demo)
            title(axes_window_DFA_Advanced_AFA,'Superposition of the integrated signal and the AFA treatment');
            xlabel(axes_window_DFA_Advanced_AFA,'Samples');
            ylabel(axes_window_DFA_Advanced_AFA,'Value');
             
            scatter(axes_Reg_DFA_Advanced_AFA,log10(scale_AFA),log10(F_AFA));
            hold(axes_Reg_DFA_Advanced_AFA,'all');
            plot(axes_Reg_DFA_Advanced_AFA,log10(scale_AFA),RegLine_AFA);
            title('Parent',axes_Reg_DFA_Advanced_AFA,'Determination of the coefficient Alpha by AFA');
            strAFA={'Alpha',num2str(Alpha_AFA)};
            xlabel('Parent',axes_Reg_DFA_Advanced_AFA,'logn');ylabel('Parent',axes_Reg_DFA_Advanced_AFA,'Fn');
            text(axes_Reg_DFA_Advanced_AFA,2,0.1,strAFA);
            Nfft=2048;
            f_fft=(-0.1:1/Nfft:0.1-1/Nfft);
            X = fftshift(abs(fft(Signal,floor(Nfft/5)))); 
           

            plot(axes_spectre_DFA_Advanced_AFA,f_fft,X);
            hold(axes_spectre_DFA_Advanced_AFA,'all');
            Y=fftshift(abs(fft(Signal_AFA_demo,floor(Nfft/5))));
            plot(axes_spectre_DFA_Advanced_AFA,f_fft,Y);
            title('Parent',axes_spectre_DFA_Advanced_AFA,'Spectrum with AFA treatement');
            xlabel('Parent',axes_spectre_DFA_Advanced_AFA,'Frequences');
            legend(axes_spectre_DFA_Advanced_AFA,'Signal Spectrum','Signal Spectrum with AFA');
            
         end      
       end
   
    end

    function option_DFA_Callback(source,~,~)
        % Determine the selected data set.
        str_option_DFA = source.String;
        val_option_DFA = source.Value;
        % Set current data to the selected data set.
        switch str_option_DFA{val_option_DFA} 
           case 'None' 
               correction=0;
               op_AFA=0;
               
                set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','off');
                set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','off');
                set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','off');
            
                set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_corr'),'Visible','off');
                set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_corr'),'Visible','off');
                
           case 'Correction' 
               correction=1;
               op_AFA=0;
               
               set(findobj(axes_Reg_DFA_Advanced_AFA,'Tag','axes_Reg_Advanced_AFA'),'Visible','off');
               set(findobj(axes_window_DFA_Advanced_AFA,'Tag','axes_Win_Advanced_AFA'),'Visible','off');
               set(findobj(axes_spectre_DFA_Advanced_AFA,'Tag','axes_Spec_Advanced_AFA'),'Visible','off');
               set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Advanced_none'),'Visible','off');
               set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','off');
               set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','off')
               
           case 'AFA'
               op_AFA=1;
               correction=0;
               
               set(findobj(axes_Reg_DFA_Advanced_corr,'Tag','axes_Reg_Advanced_corr'),'Visible','off');
               set(findobj(axes_spectre_DFA_Advanced_corr,'Tag','axes_Spec_Advanced_corr'),'Visible','off');

               set(findobj(axes_Reg_DFA_Advanced_none,'Tag','axes_Reg_Advanced_none'),'Visible','off');
               set(findobj(axes_spectre_DFA_Advanced_none,'Tag','axes_Spec_Advanced_none'),'Visible','off');
               set(findobj(axes_window_DFA_Advanced_none,'Tag','axes_Win_Advanced_none'),'Visible','off')
        end
    end

    function direction_DFA_Callback(source,~,~)
        % Determine the selected data set.
        str_direction_DFA = source.String;
        val_direction_DFA = source.Value;
        % Set current data to the selected data set.
        switch str_direction_DFA{val_direction_DFA} 
           case 'Forward & Backward' 
              forward=1;
           case 'Forward' 
              forward=0;
        end
    end

    function q_DFA_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        q = str2double(get(findobj(q_value_DFA,'Tag','q_value'),'String'));
        if isnan(q) || ~isreal(q) || q > 6 
        % Disable the Plot button and change its string to say why 
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','q invalid')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','Plot')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','on')
        end
        
    end
   

    function order_DFA_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        order = str2double(get(findobj(order_value_DFA,'Tag','order_value'),'String'));
        if isnan(order) || ~isreal(order)  
        % Disable the Plot button and change its string to say why 
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','order invalid')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','Plot')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','on')
        end
        
    end

    function Frame_DFA_input_Callback(~, ~, ~)

        % Validate that the text in the edit text field converts to a real number
        Frame=str2double(get(findobj(Frame_DFA_value,'Tag','Frame_value'),'String')); 
        if isnan(Frame) || ~isreal(Frame)  
        % Disable the Plot button and change its string to say why 
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','q invalid')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','off')
        else 
        % Enable the Plot button with its original name      
        set(findobj(DFA_plot,'Tag','plot_dfa'),'String','Plot')
        set(findobj(DFA_plot,'Tag','plot_dfa'),'Enable','on')
        end
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    function mode_PA_Callback(source3,~,~)
        % Determine the selected data set.
        str_PA = source3.String;
        val_PA = source3.Value;
        % Set current data to the selected data set.
        switch str_PA{val_PA}
                  
           case 'FFT' 
                
                set(findobj(text_global_value_PA,'Tag','txt_global_value_PA'),'Visible','on');
                set(findobj(fmin_value_PA,'Tag','fmin_value'),'Visible','on');
                set(findobj(fmax_value_PA,'Tag','fmax_value'),'Visible','on');
                set(findobj(padding_value_PA,'Tag','padding_value'),'Visible','on');
                set(findobj(text_periodo_value_PA,'Tag','txt_global_value_PA'),'Visible','on');
                set(findobj(window_value_PA,'Tag','window_PA_value'),'Visible','on');
                set(findobj(pas_value_PA,'Tag','pas_value'),'Visible','on');
                set(findobj(PA_plot,'Tag','plot_PA'),'Visible','on');
                set(findobj(text_order_max_PA,'Tag','txt_order'),'Visible','off');
                set(findobj(order_max_PA,'Tag','order_PA_value'),'Visible','off');
                set(findobj(text_order_choosen_PA,'Tag','txt_order_choosen'),'Visible','off');
                set(findobj(order_choosen_PA,'Tag','order_PA_value_choosen'),'Visible','off');
                set(findobj(PA_plot_variance,'Tag','plot_var'),'Visible','off');
                
           case 'AR Model' 
                
                set(findobj(text_global_value_PA,'Tag','txt_global_value_PA'),'Visible','on');
                set(findobj(fmin_value_PA,'Tag','fmin_value'),'Visible','on');
                set(findobj(fmax_value_PA,'Tag','fmax_value'),'Visible','on');
                set(findobj(padding_value_PA,'Tag','padding_value'),'Visible','off');
                set(findobj(text_periodo_value_PA,'Tag','txt_global_value_PA'),'Visible','on');
                set(findobj(window_value_PA,'Tag','window_PA_value'),'Visible','on');             
                set(findobj(pas_value_PA,'Tag','pas_value'),'Visible','on');
                set(findobj(text_order_max_PA,'Tag','txt_order'),'Visible','on');
                set(findobj(order_max_PA,'Tag','order_PA_value'),'Visible','on');
                set(findobj(text_order_choosen_PA,'Tag','txt_order_choosen'),'Visible','on');
                set(findobj(order_choosen_PA,'Tag','order_PA_value_choosen'),'Visible','on');
                set(findobj(PA_plot,'Tag','plot_PA'),'Visible','on');
                set(findobj(PA_plot_variance,'Tag','plot_var'),'Visible','on');

                
                order_choosen=str2double(get(findobj(order_choosen_PA,'Tag','order_PA_value_choosen'),'String'));

                

        end 
    end

    function PA_plot_Callback(~,~,~)
        

        
        if val_PA==1
            

        
        set(findobj(axes_variance,'Tag','axes_var'),'Visible','off');
        set(findobj(axes_dsp2,'Tag','axes_DSP2'),'Visible','off');
        set(findobj(axes_perio_trap,'Tag','axes_trap'),'Visible','on');
        set(findobj(axes_perio_rect,'Tag','axes_rect'),'Visible','on');
        set(findobj(axes_dsp,'Tag','axes_DSP'),'Visible','on');
        
        
        fmin=str2double(get(findobj(fmin_value_PA,'Tag','fmin_value'),'String'));
        fmax=str2double(get(findobj(fmax_value_PA,'Tag','fmin_value'),'String'));
        padding=str2double(get(findobj(padding_value_PA,'Tag','padding_value'),'String'));
        window_PA=str2double(get(findobj(window_value_PA,'Tag','window_PA_value'),'String'));
        pas=str2double(get(findobj(pas_value_PA,'Tag','pas_value'),'String'));
        N=data_length;
        Power_Spectrum = (abs(fftshift(fft(data,N+padding))).^2)/N ;
        f_norm = -1/2 : 1/(N+padding) : 1/2-1/(N+padding);
        periodo = periodogramme_2(Power_Spectrum,window_PA);
        
        
        plot(axes_dsp,f_norm,Power_Spectrum,'Color',[0.5,0.25,0.5])
        hold(axes_dsp,'all')
        plot(axes_dsp,f_norm,periodo,'-b')
        title(axes_dsp,'Estimation of the spectral density of our signal')
        legend(axes_dsp,'Power Spectrum','Estimated PSD')
        xlabel(axes_dsp,'normalized frequencies')
        ylabel(axes_dsp,'amplitude')
        
        [X,Y] = methode_rectangle(periodo,pas,fmin+padding/2,fmax+padding/2);
        X = X/(N+padding) - 1/2; 
        
        plot(axes_perio_rect,f_norm,periodo,'red')
        title(axes_perio_rect,'Rectangular method applied to the periodogram')
        hold(axes_perio_rect,'all')
        plot(axes_perio_rect,f_norm,area(X,Y))
        legend(axes_perio_rect,'Periodogram','area between fmin and fmax')
        xlabel(axes_perio_rect,'normalized frequencies')
        ylabel(axes_perio_rect,'amplitude')
        
        
        [X_TPZ, Y_TPZ] = methode_trapeze(periodo,pas_puissance,fmin+padding/2,fmax+padding/2);
        X_TPZ = X_TPZ/(N+padding) - 1/2;
        
        plot(axes_perio_trap,f_norm,periodo,'red')
        title(axes_perio_trap,'Trapezoid method applied to the periodogram')
        hold(axes_perio_trap,'all')
        plot(axes_perio_trap,f_norm,area(X_TPZ,Y_TPZ))
        legend(axes_perio_trap,'Periodogram','area between fmin and fmax')
        xlabel(axes_perio_trap,'normalized frequencies')
        ylabel(axes_perio_trap,'amplitude')
        
        else
            
        set(findobj(axes_dsp,'Tag','axes_DSP'),'Visible','off');
        set(findobj(axes_dsp2,'Tag','axes_DSP2'),'Visible','on');
        set(findobj(axes_perio_trap,'Tag','axes_trap'),'Visible','on');
        set(findobj(axes_perio_rect,'Tag','axes_rect'),'Visible','on');
        set(findobj(axes_variance,'Tag','axes_var'),'Visible','on');
                   
        
        order_choosen=str2double(get(findobj(order_choosen_PA,'Tag','order_PA_value_choosen'),'String'));
        fmin=str2double(get(findobj(fmin_value_PA,'Tag','fmin_value'),'String'));
        fmax=str2double(get(findobj(fmax_value_PA,'Tag','fmin_value'),'String'));
        window_PA=str2double(get(findobj(window_value_PA,'Tag','window_PA_value'),'String'));
        pas=str2double(get(findobj(pas_value_PA,'Tag','pas_value'),'String'));
        N=data_length;
        f_norm_2 = -1/2 : 1/N : 1/2-1/N;

        
        [h2,~,var_est] = ar_estimation(data,order_choosen);
        
        periodo_ar = periodogramme_2(abs(h2).^2*var_est,window_PA);


        plot(axes_dsp2,f_norm_2,fftshift(abs(fft(data)).^2)/N,'Color',[0.5,0.25,0.5])
        hold(axes_dsp2,'on');
        plot(axes_dsp2,f_norm_2,periodo_ar,'red')
        legend(axes_dsp2,'Estimated PSD','Periodogram')
        title(axes_dsp2,'Comparition between the estimated PSD and periodogram')
        xlabel(axes_dsp2,'normalized frequencies')
        ylabel(axes_dsp2,'amplitude')
        
        
        [X2,Y2] = methode_rectangle(periodo_ar,pas,fmin,fmax);
        X2 = X2/N - 1/2;     
        
        plot(axes_perio_rect,f_norm_2,periodo_ar,'red')
        title(axes_perio_rect,'Rectangular method applied to the periodogram')
        hold(axes_perio_rect,'on')
        plot(axes_perio_rect,f_norm_2,area(X2,Y2))
        legend(axes_perio_rect,'Periodogram','area between fmin and fmax')
        xlabel(axes_perio_rect,'normalized frequencies')
        ylabel(axes_perio_rect,'log(amplitude)')
        

        [X_TPZ2, Y_TPZ2] = methode_trapeze(periodo_ar,pas_puissance,fmin,fmax);
         X_TPZ2 = X_TPZ2/N - 1/2;

        
        plot(axes_perio_trap,f_norm_2,periodo_ar,'red')
        title(axes_perio_trap,'Trapezoid method applied to the periodogram')
        hold(axes_perio_trap,'on')
        plot(axes_perio_trap,f_norm_2,area(X_TPZ2,Y_TPZ2))
        legend(axes_perio_trap,'Periodogram','area between fmin and fmax')
        xlabel(axes_perio_trap,'normalized frequencies')
        ylabel(axes_perio_trap,'log(amplitude)')
        
        
        end
        
    end



    function PA_plot_variance_Callback(~,~,~)
        
        max_order=str2double(get(findobj(order_max_PA,'Tag','order_PA_value'),'String'));
     
        Var = [];
        p = [];

        limit_p = max_order;
        for i=1:1:limit_p
            [~,~,var_est] = ar_estimation(data,i);
            Var = [Var var_est];
            p = [p i];
        end

        
        plot(axes_variance,p,Var)
        title(axes_variance,'Variance as a function of the filter order p')
        xlabel(axes_variance,'Filter order')
        ylabel(axes_variance,'Variance')
       
    end


    function order_max_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            max_order=str2double(get(findobj(order_max_PA,'Tag','order_PA_value'),'String'));
            if isnan(max_order) || ~isreal(max_order)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot_variance,'Tag','plot_var'),'String','order max invalid')
            set(findobj(PA_plot_variance,'Tag','plot_var'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot_variance,'Tag','plot_var'),'String','Plot')
            set(findobj(PA_plot_variance,'Tag','plot_var'),'Enable','on')
            end

    end

    function order_choosen_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            order_choosen=str2double(get(findobj(order_choosen_PA,'Tag','order_PA_value_choosen'),'String'));
            if isnan(order_choosen) || ~isreal(order_choosen)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','order choosen invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end


    function fmin_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            fmin=str2double(get(findobj(fmin_value_PA,'Tag','fmin_value'),'String'));
            if isnan(fmin) || ~isreal(fmin)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','fmin invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end


    function fmax_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            fmax=str2double(get(findobj(fmax_value_PA,'Tag','fmin_value'),'String'));
            if isnan(fmax) || ~isreal(fmax)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','fmin invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end


    function padding_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            padding=str2double(get(findobj(padding_value_PA,'Tag','padding_value'),'String'));
            if isnan(padding) || ~isreal(padding)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','padding invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end


    function window_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            window_PA=str2double(get(findobj(window_value_PA,'Tag','window_PA_value'),'String'));
            if isnan(window_PA) || ~isreal(window_PA)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','window invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end

    function pas_PA_input_Callback(~, ~, ~)

            % Validate that the text in the edit text field converts to a real number
            pas=str2double(get(findobj(pas_value_PA,'Tag','pas_value'),'String'));
            if isnan(pas) || ~isreal(pas)  
            % Disable the Plot button and change its string to say why 
            set(findobj(PA_plot,'Tag','plot_PA'),'String','pas invalid')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','off')
            else 
            % Enable the Plot button with its original name      
            set(findobj(PA_plot,'Tag','plot_PA'),'String','Plot')
            set(findobj(PA_plot,'Tag','plot_PA'),'Enable','on')
            end

    end

    end
