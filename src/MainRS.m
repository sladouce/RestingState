%% RESTING STATE MATLAB SCRIPT - 2022 -
%Requirement : lib-lsl (BioSemi, Keyboard,...), Labrecorder, Python,
%EO.wav, EC.wav
%RestingState.m, Questionnaire.mlapp, ArsQ.mlapp
 

%% PATH
data_path = fullfile(fileparts(pwd),'DATA'); %Change to your path
lslapps_path = "D:\MATLAB2020\APPS"; %Inform the path of Apps folders (LabRecorder, BioSemi, Keyboard if needed,...)


%% RS Matlab  markers lsl
lib = lsl_loadlib();
info = lsl_streaminfo(lib,'MatlabMarkerStream','Markers',1,0,'cf_string','IDmatalb');
outlet = lsl_outlet(info);

%% PARTICIPANT
%provide an acronym for your project (the participants will be named after
%it)
project_acronym = 'ATARRI';
%Participant name, surname & ID
p_app  = Participant(true,project_acronym,data_path);
while isvalid(p_app)
    pause(0.1);
end

%% LabRecorder (with required Path and Participant ID)
%Biosemi Link (or any other recording tool) 
system(strcat("start ",lslapps_path,"\BioSemi\BioSemi.exe")); 
% if executable not in lsl apps path : system(strcat("start ","PATH\TO\EXE\FILE\***.exe")); 

%(if usefull) Keyboard Link : system(strcat("start ",lslapps_path,"\Keyboard\Keyboard.exe"));
disp('Press a key to open LabRecorder');
pause;
%LabRecorder
syscmd=strcat("LabRecorderSocket.py LabRecorderPath ",lslapps_path,"\LabRecorder ",data_path," ",ID);
system(syscmd);
disp('Press a key to Start Resting State');
pause;
%Demographics Questionnaire
%% RS
%mandatory : RS 5 min (30s EO + 30s EC)*5
RestingState(outlet);
%% ArsQ
%mandatory : ArsQ (post RS Questionnaire) 
arsq_app = ArsQ_RS(ID,data_path);

