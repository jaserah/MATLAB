function varargout = audioproject(varargin)
% AUDIOPROJECT MATLAB code for audioproject.fig
%      AUDIOPROJECT, by itself, creates a new AUDIOPROJECT or raises the existing
%      singleton*.
%
%      H = AUDIOPROJECT returns the handle to a new AUDIOPROJECT or the handle to
%      the existing singleton*.
%
%      AUDIOPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIOPROJECT.M with the given input arguments.
%
%      AUDIOPROJECT('Property','Value',...) creates a new AUDIOPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audioproject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audioproject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audioproject

% Last Modified by GUIDE v2.5 15-Mar-2017 11:45:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audioproject_OpeningFcn, ...
                   'gui_OutputFcn',  @audioproject_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before audioproject is made visible.
function audioproject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audioproject (see VARARGIN)

% Choose default command line output for audioproject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audioproject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audioproject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.current = handles.input1;
% guidata(hObject,handles);
global current
current = 1;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0)&& (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input1,handles.fs1);
    t = linspace(0,length(handles.input1)/handles.fs1,length(handles.input1));
    handles=guidata(hObject); 
    plot(t,handles.input1,'parent',handles.graph);
    guidata(hObject,handles); 

else
    original1 = handles.input1;
    fr1 = handles.fs1;
    if (get(handles.sample_reversal,'Value') == 1)
        original1 = flipud(original1);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original1)
            original1(i) = original1(i) + original1(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original1)
            original1(n,1) = .9*original1(n-1,1)+original1(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr1 = fr1*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr1 = fr1/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original1,2) == 1
        left = original1(:,1);
        original1 = left-left;   
        else
        left = original1(:,1);
        right = original1(:,2);
        original1 = left-right;
        end
    end
    if (get(handles.fade_out,'Value') == 1) 
        original1=original1.*linspace(1,0,length(original1))';
    end
    sound(original1,fr1);
    t = linspace(0,length(original1)/fr1,length(original1));
    handles=guidata(hObject); 
    plot(t,original1,'parent',handles.graph);
    guidata(hObject,handles);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 2;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input2,handles.fs2);
    t = linspace(0,length(handles.input2)/handles.fs2,length(handles.input2));
    handles=guidata(hObject); 
    plot(t,handles.input2,'parent',handles.graph);
    guidata(hObject,handles); 

else
    original2 = handles.input2;
    fr2 = handles.fs2;
    if (get(handles.sample_reversal,'Value') == 1)
        original2 = flipud(original2);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original2)
            original2(i) = original2(i) + original2(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original2)
            original2(n,1) = .9*original2(n-1,1)+original2(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr2 = fr2*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr2 = fr2/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original2,2) == 1
        left = original2(:,1);
        original2 = left-left;   
        else
        left = original2(:,1);
        right = original2(:,2);
        original2 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original2=original2.*linspace(1,0,length(original2))';
    end
    sound(original2,fr2);
    t = linspace(0,length(original2)/fr2,length(original2));
    handles=guidata(hObject); 
    plot(t,original2,'parent',handles.graph);
end
 

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 3;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input3,handles.fs3);
    t = linspace(0,length(handles.input3)/handles.fs3,length(handles.input3));
    handles=guidata(hObject); 
    plot(t,handles.input3,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original3 = handles.input3;
    fr3 = handles.fs3;
    if (get(handles.sample_reversal,'Value') == 1)
        original3 = flipud(original3);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original3)
            original3(i) = original3(i) + original3(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original3)
            original3(n,1) = .9*original3(n-1,1)+original3(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr3 = fr3*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr3 = fr3/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original3,2) == 1
        left = original3(:,1);
        original3 = left-left;   
        else
        left = original3(:,1);
        right = original3(:,2);
        original3 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original3=original3.*linspace(1,0,length(original3))';
    end
    sound(original3,fr3);
    t = linspace(0,length(original3)/fr3,length(original3));
    handles=guidata(hObject); 
    plot(t,original3,'parent',handles.graph);
end
 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 4;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input4,handles.fs4);
    t = linspace(0,length(handles.input4)/handles.fs4,length(handles.input4));
    handles=guidata(hObject); 
    plot(t,handles.input4,'parent',handles.graph);
    guidata(hObject,handles); 

else
    original4 = handles.input4;
    fr4 = handles.fs4;
    if (get(handles.sample_reversal,'Value') == 1)
        original4 = flipud(original4);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original4)
            original4(i) = original4(i) + original4(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original4)
            original4(n,1) = .9*original4(n-1,1)+original4(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr4 = fr4*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr4 = fr4/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original4,2) == 1
        left = original4(:,1);
        original4 = left-left;   
        else
        left = original4(:,1);
        right = original4(:,2);
        original4 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original4=original4.*linspace(1,0,length(original4))';
    end
    sound(original4,fr4);
    t = linspace(0,length(original4)/fr4,length(original4));
    handles=guidata(hObject); 
    plot(t,original4,'parent',handles.graph);
end
 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 5;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input5,handles.fs5);
    t = linspace(0,length(handles.input5)/handles.fs5,length(handles.input5));
    handles=guidata(hObject); 
    plot(t,handles.input5,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original5 = handles.input5;
    fr5 = handles.fs5;
    if (get(handles.sample_reversal,'Value') == 1)
        original5 = flipud(original5);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original5)
            original5(i) = original5(i) + original5(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original5)
            original5(n,1) = .9*original5(n-1,1)+original5(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr5 = fr5*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr5 = fr5/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original5,2) == 1
        left = original5(:,1);
        original5 = left-left;   
        else
        left = original5(:,1);
        right = original5(:,2);
        original5 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original5=original5.*linspace(1,0,length(original5))';
    end
    sound(original5,fr5);
    t = linspace(0,length(original5)/fr5,length(original5));
    handles=guidata(hObject); 
    plot(t,original5,'parent',handles.graph);
end
 


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global current
current = 6;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input6,handles.fs6);
    t = linspace(0,length(handles.input6)/handles.fs6,length(handles.input6));
    handles=guidata(hObject); 
    plot(t,handles.input6,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original6 = handles.input6;
    fr6 = handles.fs6;
    if (get(handles.sample_reversal,'Value') == 1)
        original6 = flipud(original6);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original6)
            original6(i) = original6(i) + original6(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original6)
            original6(n,1) = .9*original6(n-1,1)+original6(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr6 = fr6*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr6 = fr6/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original6,2) == 1
        left = original6(:,1);
        original6 = left-left;   
        else
        left = original6(:,1);
        right = original6(:,2);
        original6 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original6=original6.*linspace(1,0,length(original6))';
    end
    sound(original6,fr6);
    t = linspace(0,length(original6)/fr6,length(original6));
    handles=guidata(hObject); 
    plot(t,original6,'parent',handles.graph);
end
 


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 7;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input7,handles.fs7);
    t = linspace(0,length(handles.input7)/handles.fs7,length(handles.input7));
    handles=guidata(hObject); 
    plot(t,handles.input7,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original7 = handles.input7;
    fr7 = handles.fs7;
    if (get(handles.sample_reversal,'Value') == 1)
        original7 = flipud(original7);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original7)
            original7(i) = original7(i) + original7(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original7)
            original7(n,1) = .9*original7(n-1,1)+original7(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr7 = fr7*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr7 = fr7/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original7,2) == 1
        left = original7(:,1);
        original7 = left-left;   
        else
        left = original7(:,1);
        right = original7(:,2);
        original7 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original7=original7.*linspace(1,0,length(original7))';
    end
    sound(original7,fr7);
    t = linspace(0,length(original7)/fr7,length(original7));
    handles=guidata(hObject); 
    plot(t,original7,'parent',handles.graph);
end
 


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 8;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input8,handles.fs8);
    t = linspace(0,length(handles.input8)/handles.fs8,length(handles.input8));
    handles=guidata(hObject); 
    plot(t,handles.input8,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original8 = handles.input8;
    fr8 = handles.fs8;
    if (get(handles.sample_reversal,'Value') == 1)
        original8 = flipud(original8);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original8)
            original8(i) = original8(i) + original8(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original8)
            original8(n,1) = .9*original8(n-1,1)+original8(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr8 = fr8*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr8 = fr8/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original8,2) == 1
        left = original8(:,1);
        original8 = left-left;   
        else
        left = original8(:,1);
        right = original8(:,2);
        original8 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original8=original8.*linspace(1,0,length(original8))';
    end
     sound(original8,fr8);
      t = linspace(0,length(original8)/fr8,length(original8));
    handles=guidata(hObject); 
    plot(t,original8,'parent',handles.graph);
end

    
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
current = 9;
if ((get(handles.sample_reversal,'Value') == 0) && (get(handles.delay,'Value') == 0) && (get(handles.tone_control,'Value') == 0) && (get(handles.speed_up,'Value') == 0) && (get(handles.slow_down,'Value') == 0) && (get(handles.voice_removal,'Value') == 0) && (get(handles.fade_out,'Value') == 0)) 
    sound(handles.input9,handles.fs9);
    t = linspace(0,length(handles.input9)/handles.fs9,length(handles.input9));
    handles=guidata(hObject); 
    plot(t,handles.input9,'parent',handles.graph);
    guidata(hObject,handles); 
else
    original9 = handles.input9;
    fr9 = handles.fs9;
    if (get(handles.sample_reversal,'Value') == 1)
        original9 = flipud(original9);
    end
    if (get(handles.delay,'Value') == 1)
        N = 2000;
        for i = N+1:length(original9)
            original9(i) = original9(i) + original9(i-N);
        end
    end
    if (get(handles.tone_control,'Value') == 1) 
        for n = 2:length(original9)
            original9(n,1) = .9*original9(n-1,1)+original9(n,1);
        end
    end
    if (get(handles.speed_up,'Value') == 1)
        fr9 = fr9*1.5;
    end
    if (get(handles.slow_down,'Value') == 1) 
        fr9 = fr9/1.5;
    end
    if (get(handles.voice_removal,'Value') == 1) 
        if size(original9,2) == 1
        left = original9(:,1);
        original9 = left-left;   
        else
        left = original9(:,1);
        right = original9(:,2);
        original9 = left-right;
        end
    end
     if (get(handles.fade_out,'Value') == 1) 
        original9=original9.*linspace(1,0,length(original9))';
    end
    sound(original9,fr9);
    t = linspace(0,length(original9)/fr9,length(original9));
    handles=guidata(hObject); 
    plot(t,original9,'parent',handles.graph);
end
 

% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp1 = inputCell{:};
[in1,freq1]=audioread(inp1);
handles.input1 = in1; handles.fs1 = freq1;
guidata(hObject, handles);
    
% --- Executes on button press in load2.
function load2_Callback(hObject, eventdata, handles)
% hObject    handle to load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp2 = inputCell{:};
[in2,freq2]=audioread(inp2);
handles.input2 = in2; handles.fs2 = freq2;
guidata(hObject, handles);

% --- Executes on button press in load3.
function load3_Callback(hObject, eventdata, handles)
% hObject    handle to load3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp3 = inputCell{:};
[in3,freq3]=audioread(inp3);
handles.input3 = in3; handles.fs3 = freq3;
guidata(hObject, handles);

% --- Executes on button press in load4.
function load4_Callback(hObject, eventdata, handles)
% hObject    handle to load4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp4 = inputCell{:};
[in4,freq4]=audioread(inp4);
handles.input4 = in4; handles.fs4 = freq4;
guidata(hObject, handles);

% --- Executes on button press in load5.
function load5_Callback(hObject, eventdata, handles)
% hObject    handle to load5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp5 = inputCell{:};
[in5,freq5]=audioread(inp5);
handles.input5 = in5; handles.fs5 = freq5;
guidata(hObject, handles);

% --- Executes on button press in load6.
function load6_Callback(hObject, eventdata, handles)
% hObject    handle to load6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp6 = inputCell{:};
[in6,freq6]=audioread(inp6);
handles.input6 = in6; handles.fs6 = freq6;
guidata(hObject, handles);


% --- Executes on button press in load7.
function load7_Callback(hObject, eventdata, handles)
% hObject    handle to load7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp7 = inputCell{:};
[in7,freq7]=audioread(inp7);
handles.input7 = in7; handles.fs7 = freq7;
guidata(hObject, handles);


% --- Executes on button press in load8.
function load8_Callback(hObject, eventdata, handles)
% hObject    handle to load8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp8 = inputCell{:};
[in8,freq8]=audioread(inp8);
handles.input8 = in8; handles.fs8 = freq8;
guidata(hObject, handles);


% --- Executes on button press in load9.
function load9_Callback(hObject, eventdata, handles)
% hObject    handle to load9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputCell = inputdlg('Please input name of file (including .wav):');
inp9 = inputCell{:};
[in9,freq9]=audioread(inp9);
handles.input9 = in9; handles.fs9 = freq9;
guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start as text
%        str2double(get(hObject,'String')) returns contents of start as a double


% --- Executes during object creation, after setting all properties.
function start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stop as text
%        str2double(get(hObject,'String')) returns contents of stop as a double


% --- Executes during object creation, after setting all properties.
function stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double


% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sample_reversal.
function sample_reversal_Callback(hObject, eventdata, handles)
% hObject    handle to sample_reversal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sample_reversal


% --- Executes on button press in delay.
function delay_Callback(hObject, eventdata, handles)
% hObject    handle to delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delay


% --- Executes on button press in tone_control.
function tone_control_Callback(hObject, eventdata, handles)
% hObject    handle to tone_control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tone_control


% --- Executes on button press in speed_up.
function speed_up_Callback(hObject, eventdata, handles)
% hObject    handle to speed_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of speed_up


% --- Executes on button press in slow_down.
function slow_down_Callback(hObject, eventdata, handles)
% hObject    handle to slow_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of slow_down


% --- Executes on button press in voice_removal.
function voice_removal_Callback(hObject, eventdata, handles)
% hObject    handle to voice_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of voice_removal


% --- Executes on selection change in chop_sample.
function chop_sample_Callback(hObject, eventdata, handles)
% hObject    handle to chop_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chop_sample contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chop_sample


% --- Executes during object creation, after setting all properties.
function chop_sample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chop_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in waveform_type.
function waveform_type_Callback(hObject, eventdata, handles)
% hObject    handle to waveform_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns waveform_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from waveform_type


% --- Executes during object creation, after setting all properties.
function waveform_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waveform_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_signature_Callback(hObject, eventdata, handles)
% hObject    handle to time_signature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_signature as text
%        str2double(get(hObject,'String')) returns contents of time_signature as a double


% --- Executes during object creation, after setting all properties.
function time_signature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_signature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bpm_Callback(hObject, eventdata, handles)
% hObject    handle to bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bpm as text
%        str2double(get(hObject,'String')) returns contents of bpm as a double

beats_per = str2double(get(hObject,'String'));
handles.bpmin = beats_per;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_bars_Callback(hObject, eventdata, handles)
% hObject    handle to num_bars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_bars as text
%        str2double(get(hObject,'String')) returns contents of num_bars as a double

num_bars = str2double(get(hObject,'String'));
handles.bars = num_bars;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function num_bars_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_bars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current
num_bars = handles.bars;
x = 4*num_bars; %number of beats in sample
y = (handles.bpmin)/60; %number of beats per second
sec = x/y; %seconds in sample
loop_array = 1:sec;
max_allowed_length = 1400000;
new_array = zeros(max_allowed_length,1);
increment = 100;
inc = 1;
current = 0;
for i = loop_array
    pause(1)
    if current==1
        new_array(inc:increment) = handles.input1(inc:increment);
        disp('#1 playing');
        disp(new_array(inc:increment));
    end
    if current==2
        new_array(inc:increment) = handles.input2(inc:increment);
        disp('#2 playing');
        disp(new_array(inc:increment));
    end
    if current==3
        new_array(inc:increment) = handles.input3(inc:increment);
        disp('#3 playing');
        disp(new_array(1:inc));
    end
    if current==4
        new_array(inc:increment) = handles.input4(inc:increment);
        disp('#4 playing');
        disp(new_array(1:inc));
    end
    if current==5
        new_array(inc:increment) = handles.input5(inc:increment);
        disp('#5 playing');
        disp(new_array(1:inc));
    end
    if current==6
        new_array(inc:increment) = handles.input6(inc:increment);
        disp('#6 playing');
        disp(new_array(1:inc));
    end
    if current==7
        new_array(inc:increment) = handles.input7(inc:increment);
        disp('#7 playing');
        disp(new_array(1:inc));
    end
    if current==8
        new_array(inc:increment) = handles.input8(inc:increment);
        disp('#8 playing');
        disp(new_array(1:inc));
    end
    if current==9
        new_array(inc:increment) = handles.input9(inc:increment);
        disp('#9 playing');
        disp(new_array(1:inc));
        
    end
    if current == 0
        disp('0');
    end
    inc = increment;
    increment = increment+100;
    
end
handles.p = audioplayer(new_array,44100);
guidata(hObject,handles);


        



% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
play(handles.p);

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in chop.
function chop_Callback(hObject, eventdata, handles)
% hObject    handle to chop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = get(handles.chop_sample,'Value');
start_string = get(handles.start,'String');
stop_string = get(handles.stop,'String');
start_num = str2num(start_string);
stop_num = str2num(stop_string);
x = start_num;
z = stop_num;

switch selection
    case 1
        if x == 0
            input1_chopped = handles.input1(1:(z*handles.fs1));
        else
        input1_chopped = handles.input1((x*handles.fs1):(z*handles.fs1));
        end
        handles.input1 = input1_chopped;
    case 2
        if x == 0
            input2_chopped = handles.input2(1:(z*handles.fs2));
        else
        input2_chopped = handles.input2((x*handles.fs2):(z*handles.fs2));
        end
        handles.input2 = input2_chopped;
    case 3
        if x == 0
            input3_chopped = handles.input3(1:(z*handles.fs3));
        else
        input3_chopped = handles.input3((x*handles.fs3):(z*handles.fs3));
        end
        handles.input3 = input3_chopped;
    case 4
        if x == 0
            input4_chopped = handles.input4(1:(z*handles.fs4));
        else
        input4_chopped = handles.input4((x*handles.fs4):(z*handles.fs4));
        end  
        handles.input4 = input4_chopped;
    case 5
        if x == 0
            input5_chopped = handles.input5(1:(z*handles.fs5));
        else
        input5_chopped = handles.input5((x*handles.fs5):(z*handles.fs5));
        end
        handles.input5 = input5_chopped;
    case 6
        if x == 0
            input6_chopped = handles.input6(1:(z*handles.fs6));
        else
        input6_chopped = handles.input6((x*handles.fs6):(z*handles.fs6));
        end
        handles.input6 = input6_chopped;
    case 7
        if x == 0
            input7_chopped = handles.input7(1:(z*handles.fs7));
        else
        input7_chopped = handles.input7((x*handles.fs7):(z*handles.fs7));
        end
        handles.input7 = input7_chopped;
    case 8
        if x == 0
            input8_chopped = handles.input8(1:(z*handles.fs8));
        else
        input8_chopped = handles.input8((x*handles.fs8):(z*handles.fs8));
        end
        handles.input8 = input8_chopped;
    case 9
        if x == 0
            input9_chopped = handles.input9(1:(z*handles.fs9));
        else
        input9_chopped = handles.input9((x*handles.fs9):(z*handles.fs9));
        end
        handles.input9 = input9_chopped;
end
guidata(hObject,handles)



% --- Executes on button press in do_waveform.
function do_waveform_Callback(hObject, eventdata, handles)
% hObject    handle to do_waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch (get(handles.waveform_type,'Value'))
    case 1
        input_cell = get(handles.frequency,'String');
        user_fs = str2num(input_cell);
        t = linspace(0,4,40000);
        y = sin(user_fs.*2.*pi.*t);
        sound(y,10000);
    case 2
        input_cell = get(handles.frequency,'String');
        user_fs = str2num(input_cell);
        t = linspace(0,4,40000);
        y = square(user_fs.*2.*pi.*t);
        sound(y,10000);
end

% --- Executes on button press in fade_out.
function fade_out_Callback(hObject, eventdata, handles)
% hObject    handle to fade_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fade_out


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stop_all.
function stop_all_Callback(hObject, eventdata, handles)
% hObject    handle to stop_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;
