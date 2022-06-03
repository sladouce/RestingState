function RestingState(outlet)
%% Resting State parameters
RS_rep=5; % Resting State repetition
RS_duration=30; % Resting State Duration
pause_RS=2; % Pause between Eyes closed and Eyes open during Resting State

% Load auditory files
[yEO,Fs] = audioread(fullfile(fileparts(pwd),'sound\EO.wav')); %
[yEC,Fs] = audioread(fullfile(fileparts(pwd),'sound\EC.wav'));

% Launch LSL streams for Matlab marker stream
markers={'RS_EO','RS_EC'};

%% Launch Resting State
figure('menubar','none') ;
set(gcf,'WindowState','fullscreen')
hold on;
instructions = sprintf('Resting state (5 mn)\nAppuyez sur entrer pour continuer');
th = text(1,1,instructions,'fontsize',40);
set(gca,'visible','off','xlim',[0 2],'ylim',[0 2],'Position',[0 0 1 1]) ;
set(gcf,'color',[0.8 0.8 0.8]);
set(th,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle')
w = waitforbuttonpress;

delete(th)
instructions = sprintf('Lisez les instructions et laissez libre cours à vos pensées\nAppuyez sur "Entrée" quand vous êtes prêt à commencer');
th = text(1,1,instructions,'fontsize',40);
set(th,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle')
w = waitforbuttonpress;

% Launch RS task
for i = 1:RS_rep
    
    % Resting state (Eyes Open, 30s)
    delete(th)
    th = text(1,1,'Gardez les yeux ouverts et fixez la croix','fontsize',40);
    set(th,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle')
    sound(yEO,Fs);%Eyes Open
    pause(5)
    delete(th)
    th = text(1,1,'+','fontsize',40);
    set(th,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle')
    pause(pause_RS)
    outlet.push_sample(markers(1)); % Markers for RS EO
    disp(markers{1});
    pause(RS_duration)
    
    % Resting state (Eyes Closed, 30s)
    delete(th)
    sound(yEC,Fs);%Eyes Close;
    th = text(1,1,'Fermez les yeux','fontsize',40);
    set(th,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle')
    pause(pause_RS)
    outlet.push_sample(markers(2)); % Markers for RS EC
    disp(markers{2});
    pause(RS_duration)
end
sound(yEO,Fs);%Eyes Close;
close all
end


