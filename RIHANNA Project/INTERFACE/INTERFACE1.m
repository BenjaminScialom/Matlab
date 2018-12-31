function INTERFACE1

close all
%%  Create and then hide the GUI as it is being constructed.

f = figure('Visible','off','Position',[100,800,1000,800]);

%% Variable initialization

data = 0;
val=1;

%%  Construct the components.

fpanel_Signal = uipanel('Title','Signal','FontSize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.8 0.98 0.2]);

Axes_signal = axes('parent',fpanel_Signal,'Position',[0.3 0.2 0.75 0.75]);


artefac_choice = uicontrol('parent',fpanel_Signal,'Style','popupmenu',...
    'String',{'with artefac','without artefac',},...
    'Position',[25,40,100,40],...
    'Callback',@artefac_Callback);

signal_choice = uicontrol('parent',fpanel_Signal,'Style','pushbutton','String','Select Data',...
    'Position',[25,90,100,40],...
    'Callback',@signal_choice_Callback);

signal_plot = uicontrol('parent',fpanel_Signal,'Style','pushbutton','String','Plot',...
    'Position',[25,10,100,40],...
    'Callback',@signal_plot_Callback);

lambda_input = uicontrol('parent',fpanel_Signal,'Style','edit','String','0.5',...
    'Position',[135,50,100,40],...
    'Callback',@lambda_input_Callback);

fpanel_Methodes = uipanel('Title','Analysis','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.98 0.8]);


tabgp = uitabgroup(fpanel_Methodes,'units','normalized','Position',[.01 .01 .98 .98]);
tab1 = uitab(tabgp,'Title','EMD','ButtonDownFcn',@emd_callback);
tab2 = uitab(tabgp,'Title','DFA');
tab3 = uitab(tabgp,'Title','MSE');
tab4 = uitab(tabgp,'Title','Power Analysis');
tab5 = uitab(tabgp,'Title','DKL-DJ');

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

Data_DFA_panel = uipanel('parent',tab2,'Title','Data','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.5 0.97]);

Display_DFA_panel = uipanel('parent',tab2,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.49 0.01 0.5 0.97]);


Display_MSE_panel = uipanel('parent',tab3,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.98 0.98]);

Data_MSE_table = uitable('parent',Display_MSE_panel,...
                 'Position', [5 50 185 100],...
                 'ColumnWidth','auto',...
                 'Data', {'Maximum Scale',6;'Pattern length',2;'Criterion of selection tolerance',0.15}, ...
                 'ColumnName', {'Parameter','Value'},...
                 'ColumnEditable', [false true]);
             
textmse = uicontrol('Parent',Display_MSE_panel,'Style','text','BackgroundColor','white',...
    'String','Please enter parameters before running :',...
    'Position',[5 150 185 30]);

haxes_mse = axes('Parent',Display_MSE_panel,'Units', 'normalized',...
             'Position', [0.3 .065 .50 .85]);
         
title(haxes_mse, 'Multiscale Entropy')   % Describe data set
% Prevent axes from clearing when new lines or markers are plotted
hold(haxes_mse, 'all')

             
hmse = uicontrol('parent',Display_MSE_panel,'Style','pushbutton','String','MSE',...
'Units','normalized','Position',[0,0.002,0.1,0.05],...
'Callback',@mse_callback);

Data_Power_Analysis_panel = uipanel('parent',tab4,'Title','Data','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.5 0.97]);

Display_Power_Analysis_panel = uipanel('parent',tab4,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.49 0.01 0.5 0.97]);

Data_Div_panel = uipanel('parent',tab5,'Title','Data','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.01 0.01 0.5 0.97]);

Display_Div_panel = uipanel('parent',tab5,'Title','Method Display','Fontsize',12,...
    'BackgroundColor','white',...
    'Position',[0.49 0.01 0.5 0.97]);

%% Global display option

% Assign the GUI a name to appear in the window title.
f.Name = 'RIHANNA Interface';
% Move the GUI to the center of the screen.
movegui(f,'center')
% Make the GUI visible.
f.Visible = 'on';


%% Callbacks

%     Callbacks for INTERFACE. These callbacks automatically
%     have access to component handles and initialized data
%     because they are nested at a lower level.
%
%     Pop-up menu callback. Read the pop-up menu Value property
%     to determine if the plot is with or without artefac.

    function artefac_Callback(source,eventdata,handles)
        % Determine the selected data set.
        str = source.String;
        val = source.Value;
        % Set current data to the selected data set.
        switch str{val}
            case 'with artefac' % User selects Peaks.
                
                %[x,~] = ginput(2);
                %plot(Axes_signal,data(x(1):x(2)));
                
            case 'without artefac' % User selects Membrane.

        end
    end

% Push button callbacks.

    function signal_choice_Callback(~,eventdata,handles)
        % Choose the current data to display in the axes
        
        [filename, pathname] = uigetfile('*.mat', 'Select a MATLAB code file');
        if isequal(filename,0)
            disp('User selected Cancel')
        else
            disp(['User selected ', fullfile(filename)])
            data = importdata(filename);
            data = data(~isnan(data));          
        end     
    end

    function signal_plot_Callback(source,eventdata,handles)
        
        if val==1
            plot(Axes_signal,data);
     
        else
            lambda = str2double(get(handles.lambda_input,'String'));
            Tfilt = Filtre_Tarvainen(data,lambda);
            plot(Axes_signal,data)
            hold(Axes_signal, 'all')
            plot(Axes_signal,data-Tfilt, 'r-')
            hold(Axes_signal, 'all')
            plot(Axes_signal,Tfilt)
           
        end
        
    end


    function lambda_input_Callback(hObject, eventdata, handles)
    % hObject    handle to f1_input (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of f1_input as text
    %        str2double(get(hObject,'String')) returns contents of f1_input
    %        as a double

    % Validate that the text in the f1 field converts to a real number
        lambda = str2double(get(hObject,'String'));
        if isnan(lambda) || ~isreal(lambda)  
        % isdouble returns NaN for non-numbers and f1 cannot be complex
        % Disable the Plot button and change its string to say why
        set(handles.signal_plot,'String','Cannot plot f1')
        set(handles.signal_plot,'Enable','off')
        % Give the edit text box focus so user can correct the error
        uicontrol(hObject)
        else 
        % Enable the Plot button with its original name
        set(handles.signal_plot,'String','Plot')
        set(handles.signal_plot,'Enable','on')
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function emd_callback(source,eventdata,handles);
       
        IMF = emd(data);
        n = size(IMF,1);

        for i = 1 : n
            subplot(n,1,i,'Parent', Display_EMD_panel);
            plot(IMF(i,:))  
        end
    end

    function spec_emd_callback(source,eventdata,handles);
       
        IMF = emd(data);
        n = size(IMF,1);

        for i = 1 : n
            subplot(n,1,i,'Parent', Display_EMD_panel);
            spectrogram(IMF(i,:))  
        end
    view([-90 90])
    end

    function display_emd_callback(source,eventdata,handles);
        
        IMF = emd(data,'display',1);
        n = size(IMF,1);

        for i = 1 : n
            
            subplot(n,1,i,'Parent', Display_EMD_panel);
            plot(IMF(i,:))
            
        end
    end
       

function mse_callback(source,eventdata,handles);
       
        mse_v = multise(data,Data_MSE_table.Data{1,2},Data_MSE_table.Data{2,2},Data_MSE_table.Data{3,2})
        plot(haxes_mse,[1 :Data_MSE_table.Data{1,2}],mse_v)
        xlabel('scale')
        ylabel('SampEn')
    end
        
%         for i = 1 : n
%             
%             subplot(n,1,i)
%             spectrogram(ans(i,:),100,80,100,'yaxis')
%             
%         end
%         
%         figure
%         
%         subplot(2,1,1)
%         plot(SimonRRlay)
%         
%         subplot(2,1,2)
%         spectrogram(SimonRRlay,100,90,100,100,'yaxis')
        
    end
