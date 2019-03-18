%****************************************************************
% Modul			  : TestSimpleKalman.m                          *
%				                            					*
% Datum           : 22. September 2016                          *
%                                                               *
% Funktion        : Startfunktion eines Kalman-Filters          *
%                                                               *
% Implementation  : MATLAB 2016a                  			    *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Ulrich Schneider       *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 13. September 2016                          *
%                                                               *
%***************************************************************/

clear all; close all; clc % MATLAB vorbereiten

dt = 0.2;     % Abtastzeit in s
t  = 0:dt:10; % Zeitachse als Array

nSamples = length(t);

Xsaved = zeros(nSamples, 1);
Zsaved = zeros(nSamples, 1);

for k=1:nSamples
  z        = LeseSpannung();  % Messwerte lesen
  Spannung = SimpelKalman(z); % Kalman-Filter
  
  % Messwerte speichern
  Xsaved(k) = Spannung;
  Zsaved(k) = z;
end

figure
hold on
plot(t, Zsaved, 'r:.') 
plot(t, Xsaved, 'o-')
legend('Messwerte','Kalman-Filter Schätzung')
xlabel('Zeit in s')
ylabel('Batteriespannung in V')