function varargout = SCARA_GUI(varargin)
% SCARA_GUI MATLAB code for SCARA_GUI.fig
%      SCARA_GUI, by itself, creates a new SCARA_GUI or raises the existing
%      singleton*.
%
%      H = SCARA_GUI returns the handle to a new SCARA_GUI or the handle to
%      the existing singleton*.
%
%      SCARA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA_GUI.M with the given input arguments.
%
%      SCARA_GUI('Property','Value',...) creates a new SCARA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SCARA_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SCARA_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SCARA_GUI

% Last Modified by GUIDE v2.5 13-May-2024 10:36:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SCARA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SCARA_GUI_OutputFcn, ...
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


% --- Executes just before SCARA_GUI is made visible.
function SCARA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SCARA_GUI (see VARARGIN)

% Choose default command line output for SCARA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SCARA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SCARA_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function q_1_Callback(hObject, eventdata, handles)
% hObject    handle to q_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_1 as text
%        str2double(get(hObject,'String')) returns contents of q_1 as a double


% --- Executes during object creation, after setting all properties.
function q_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_2_Callback(hObject, eventdata, handles)
% hObject    handle to q_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_2 as text
%        str2double(get(hObject,'String')) returns contents of q_2 as a double


% --- Executes during object creation, after setting all properties.
function q_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_3_Callback(hObject, eventdata, handles)
% hObject    handle to q_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_3 as text
%        str2double(get(hObject,'String')) returns contents of q_3 as a double


% --- Executes during object creation, after setting all properties.
function q_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FK_button.
function FK_button_Callback(hObject, eventdata, handles)
% hObject    handle to FK_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    q_1 = str2double(handles.q_1.String)*pi/180;
    q_2 = str2double(handles.q_2.String);
    q_3 = str2double(handles.q_3.String)*pi/180;
    q_4 = str2double(handles.q_4.String)*pi/180;
    
    [L1, L2, L3, L4] = parameter();
    
    H0_1 = Link([0, 0, 0, 0, 0, 0]);
    H0_1.qlim = [-5*pi/6 5*pi/6];
    
    H1_2 = Link([0, 0, L2, 0, 1, L1]);
    H1_2.qlim = [0 200];
    
    H2_3 = Link([0, 0, L3, 0, 0, 0]);
    H2_3.qlim = [-5*pi/6 5*pi/6];
    
    H3_E = Link([0, 0, L4, 0, 0, 0]);
    H3_E.qlim = [-pi/2 pi/2];
    
    SCARA = SerialLink([H0_1 H1_2 H2_3 H3_E], "name", "SCARA");
    SCARA.plot([q_1 q_2 q_3 q_4]);
    
    T = SCARA.fkine([q_1 q_2 q_3 q_4]);
    handles.pos_X.String = num2str(T.t(1));
    handles.pos_Y.String = num2str(T.t(2));
    handles.pos_Z.String = num2str(T.t(3));

function pos_X_Callback(hObject, eventdata, handles)
% hObject    handle to pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_X as text
%        str2double(get(hObject,'String')) returns contents of pos_X as a double


% --- Executes during object creation, after setting all properties.
function pos_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_Y_Callback(hObject, eventdata, handles)
% hObject    handle to pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_Y as text
%        str2double(get(hObject,'String')) returns contents of pos_Y as a double


% --- Executes during object creation, after setting all properties.
function pos_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_Z_Callback(hObject, eventdata, handles)
% hObject    handle to pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_Z as text
%        str2double(get(hObject,'String')) returns contents of pos_Z as a double


% --- Executes during object creation, after setting all properties.
function pos_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_4_Callback(hObject, eventdata, handles)
% hObject    handle to q_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_4 as text
%        str2double(get(hObject,'String')) returns contents of q_4 as a double


% --- Executes during object creation, after setting all properties.
function q_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in IK_button.
function IK_button_Callback(hObject, eventdata, handles)
% hObject    handle to IK_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    PX = str2double(handles.pos_X.String);
    PY = str2double(handles.pos_Y.String);
    PZ = str2double(handles.pos_Z.String);

    [L1, L2, L3, L4] = parameter();
    
    H0_1 = Link([0, 0, 0, 0, 0, 0]);
    H0_1.qlim = [-5*pi/6 5*pi/6];
    
    H1_2 = Link([0, 0, L2, 0, 1, L1]);
    H1_2.qlim = [0 200];
    
    H2_3 = Link([0, 0, L3, 0, 0, 0]);
    H2_3.qlim = [-5*pi/6 5*pi/6];
    
    H3_E = Link([0, 0, L4, 0, 0, 0]);
    H3_E.qlim = [-pi/2 pi/2];
    
    SCARA = SerialLink([H0_1 H1_2 H2_3 H3_E], "name", "SCARA");

    T = [ 1 0 0 PX;
            0 1 0 PY;
            0 0 1 PZ;
            0 0 0 1];
      
    q = SCARA.ikine(T, [0 0 0 0 0 0], 'mask', [1 1 1 1 0 0]) * 180/pi;
    handles.q_1.String = num2str(round(q(1),2));
    handles.q_2.String = num2str(round(PZ-L1,2));
    handles.q_3.String = num2str(round(q(3),2));
    handles.q_4.String = num2str(round(q(4),2));
    
    SCARA.plot(q*pi/180);



function gripper_Callback(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gripper as text
%        str2double(get(hObject,'String')) returns contents of gripper as a double


% --- Executes during object creation, after setting all properties.
function gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in move_robot.
function move_robot_Callback(hObject, eventdata, handles)
% hObject    handle to move_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    msg = handles.q_1.String + ";" + handles.q_2.String + ";" + handles.q_3.String + ";" + handles.q_4.String + ";" + handles.gripper.String + ";!";
%     write(arduino,msg,"string")
    global x;
    fprintf(x,msg,"string");


% --- Executes on button press in connect.
function conenct_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global x;
    x=serialport('COM8', 9600);
