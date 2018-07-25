% Created by Felipe Bittencourt de Souza - August 2017.

% This script was used to receive GPS data from an Arduino board in a computer using MATLAB, but it can be used to fetch data from any other serial connection.
% The purpose was to plot the GPS positions in real time and save it in a log file using CVS format (data separated using a comma delimiter).

% Requirements:
%   - Data must be sent through Serial port.
%   - Variables must be sent separated by a comma ',' with a carriage return and newline characters after the last variable. Example: Serial.println()


% To use it with an Arduino:
%   - The Arduino board must be connected to the computer via USB port;
%   - Data must be send using Serial.print() and Serial.println() functions.
% Example:
%       To send the following variables: Latitude = -401034; Longitude = -501343; RandomData = 12314;
%               Serial.print("%d", Latitude)
%               Serial.print("%d", Longitude)
%               Serial.println("%d", RandomData)

%clear all
%clc
format long
 
% For macOS users: /dev/tty.usbmodem1411 
% For Windows users: COM3, COM9, etc
arduino=serial('/dev/tty.usbmodem1411','BaudRate',9600); % set serial object


%arduino.InputBufferSize = 16 % set buffer size

try
    fopen(arduino); % open serial connection
catch err
    test = instrfind; % check opened connections
    fclose(test); % close existing conections
    delete(test); % delete all connections variables
    error('Check if Arduino is really connected to the specified port.');
end

% open file to create the log header and to save it
fileID = fopen('ARDUINO1.txt','w') % filename to save all the data
fprintf(fileID,'%8s,%9s,%13s,%6s,%4s,%25s,%2s\n','Latitude','Longitude','Ponto Destino','Angulo','Erro','Angulo da Minha Trajetoria','id'); % variables passed from arduino through Serial.print() function

numberofcolumns = 7; % number of columns => number of variables

dialogBox = uicontrol('Style', 'PushButton', 'String', 'Break','Callback', 'delete(gcbf)')
hold on
pause(3) % wait for things to happen

while (ishandle(dialogBox))
    arduino.BytesAvailable
    res = fscanf(arduino,'%s'); % read serial buffer until next cr lf characteres (end of line)
    
    fprintf(fileID,'%20s\n',res)
    
    points = strsplit(res,','); % split string read from serial into an array of variables using a comma delimiter ','
    points = str2double(points) % convert the array of strings to array of doubles 
    if (size(points,2) == numberofcolumns) % check if points data has two columns, which was required for the gps application (lat and long)
        plot(points(2),points(1),'r+') % ploting real-time data 
    end
  %end
    pause(0.5)
end
hold off

fclose(arduino); % VERY important! Close the serial connection object
fclose(fileID);

clear all
clc

% Things to improve:
% - Create a decent way to define number of variables and log header.
% - Give a better attention to the UI control function
% - If program freezes, the data is not saved properly