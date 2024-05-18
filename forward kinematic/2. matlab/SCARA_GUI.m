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

% Last Modified by GUIDE v2.5 19-May-2024 00:07:59

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
    global x;
    fprintf(x,msg,"string");
    msg = "end!";
    fprintf(x,msg,"string");


% --- Executes on button press in connect.
function conenct_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global x;
    x=serialport('COM4', 9600);



function X_start_Callback(hObject, eventdata, handles)
% hObject    handle to X_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_start as text
%        str2double(get(hObject,'String')) returns contents of X_start as a double


% --- Executes during object creation, after setting all properties.
function X_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_start_Callback(hObject, eventdata, handles)
% hObject    handle to Y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_start as text
%        str2double(get(hObject,'String')) returns contents of Y_start as a double


% --- Executes during object creation, after setting all properties.
function Y_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_start_Callback(hObject, eventdata, handles)
% hObject    handle to Z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_start as text
%        str2double(get(hObject,'String')) returns contents of Z_start as a double


% --- Executes during object creation, after setting all properties.
function Z_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_end_Callback(hObject, eventdata, handles)
% hObject    handle to X_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_end as text
%        str2double(get(hObject,'String')) returns contents of X_end as a double


% --- Executes during object creation, after setting all properties.
function X_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_end_Callback(hObject, eventdata, handles)
% hObject    handle to Y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_end as text
%        str2double(get(hObject,'String')) returns contents of Y_end as a double


% --- Executes during object creation, after setting all properties.
function Y_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_end_Callback(hObject, eventdata, handles)
% hObject    handle to Z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_end as text
%        str2double(get(hObject,'String')) returns contents of Z_end as a double


% --- Executes during object creation, after setting all properties.
function Z_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start_line.
function Start_line_Callback(hObject, eventdata, handles)
% hObject    handle to Start_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla;
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

    X_start = str2double(handles.X_start.String);
    Y_start = str2double(handles.Y_start.String);
    Z_start = str2double(handles.Z_start.String);

    X_end = str2double(handles.X_end.String);
    Y_end = str2double(handles.Y_end.String);
    Z_end = str2double(handles.Z_end.String);

    Step = str2double(handles.Step.String);

    [Ed,~]=Quydaoduongthang([X_start Y_start Z_start], [X_end Y_end Z_end], Step);
    
    global x;
    Q_real = [];
    init_q = [0 0 0 0];
    plot3(Ed(1,:), Ed(2,:), Ed(3,:), 'r.');
    hold on
    for i = 1:1:length(Ed)
        obj = transl(Ed(:,i)) * rpy2tr(0, 0, 0);
        q = SCARA.ikine(obj, [init_q 0 0], 'mask', [1 1 1 1 0 0]) * 180/pi;
        init_q = q;
        handles.q_1.String = num2str(round(q(1),2));
        handles.q_2.String = num2str(round(Ed(3,i)-L1,2));
        handles.q_3.String = num2str(round(q(3),2));
        handles.q_4.String = num2str(round(q(4),2));
        SCARA.plot(q*pi/180);
        Q_real(1,end+1) = round(q(1),2);
        Q_real(2,end) = round(Ed(3,i)-L1,2);
        Q_real(3,end) = round(q(3),2);
        Q_real(4,end) = round(q(4),2);
    end
%     length(Q_real)
%     Q_real;
    for i = 1:1:length(Q_real)
        msg = Q_real(1,i) + ";" + Q_real(2,i) + ";" + Q_real(3,i) + ";" + Q_real(4,i) + ";" + handles.gripper.String + ";!";
        fprintf(x,msg,"string");
    end
    msg = "end!";
    fprintf(x,msg,"string");

function Step_Callback(hObject, eventdata, handles)
% hObject    handle to Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step as text
%        str2double(get(hObject,'String')) returns contents of Step as a double


% --- Executes during object creation, after setting all properties.
function Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CenterX_Callback(hObject, eventdata, handles)
% hObject    handle to CenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CenterX as text
%        str2double(get(hObject,'String')) returns contents of CenterX as a double


% --- Executes during object creation, after setting all properties.
function CenterX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CenterY_Callback(hObject, eventdata, handles)
% hObject    handle to CenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CenterY as text
%        str2double(get(hObject,'String')) returns contents of CenterY as a double


% --- Executes during object creation, after setting all properties.
function CenterY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Radius_Callback(hObject, eventdata, handles)
% hObject    handle to Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Radius as text
%        str2double(get(hObject,'String')) returns contents of Radius as a double


% --- Executes during object creation, after setting all properties.
function Radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start_circle.
function Start_circle_Callback(hObject, eventdata, handles)
% hObject    handle to Start_circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla;
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

    CenterX = str2double(handles.CenterX.String);
    CenterY = str2double(handles.CenterY.String);

    Radius = str2double(handles.Radius.String);
    Height = str2double(handles.Height.String);

    Step = str2double(handles.Step_circle.String);

    [Ed,~]=Quydaoduongtron([CenterX CenterY], Radius, Height, Step);
    
    global x;
    Q_real = [];
    init_q = [0 0 0 0];
    plot3(Ed(1,:), Ed(2,:), Ed(3,:), 'r.');
    hold on
    for i = 1:1:length(Ed)
        obj = transl(Ed(:,i)) * rpy2tr(0, 0, 1);
        q = SCARA.ikine(obj, [init_q 0 0], 'mask', [1 1 1 1 0 0]) * 180/pi;
        init_q = q;
        handles.q_1.String = num2str(round(q(1),2));
        handles.q_2.String = num2str(round(Ed(3,i)-L1,2));
        handles.q_3.String = num2str(round(q(3),2));
        handles.q_4.String = num2str(round(q(4),2));
        SCARA.plot(q*pi/180);
        Q_real(1,end+1) = round(q(1),2);
        Q_real(2,end) = round(Ed(3,i)-L1,2);
        Q_real(3,end) = round(q(3),2);
        Q_real(4,end) = round(q(4),2);
    end
%     length(Q_real)
%     Q_real;
    for i = 1:1:length(Q_real)
        msg = Q_real(1,i) + ";" + Q_real(2,i) + ";" + Q_real(3,i) + ";" + Q_real(4,i) + ";" + handles.gripper.String + ";!";
        fprintf(x,msg,"string");
    end
    msg = "end!";
    fprintf(x,msg,"string");


function Step_circle_Callback(hObject, eventdata, handles)
% hObject    handle to Step_circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_circle as text
%        str2double(get(hObject,'String')) returns contents of Step_circle as a double


% --- Executes during object creation, after setting all properties.
function Step_circle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Height_Callback(hObject, eventdata, handles)
% hObject    handle to Height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Height as text
%        str2double(get(hObject,'String')) returns contents of Height as a double


% --- Executes during object creation, after setting all properties.
function Height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
