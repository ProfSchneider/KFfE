%****************************************************************
% Modul			  : TestDvKalman.m                              *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Start-Skript für die Geschwindigkeits-      *
%                   schätzung eines Zuges anhand der Positions- *
%                   messung                                     *
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

global dt
dt = 0.1;     % Abtastzeit in s
t  = 0:dt:10; % Zeitachse als Array

nSamples = length(t); % Anzahl der Messwerte

Xsaved = zeros(nSamples, 2); % Speicherplatz reservieren
Zsaved = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples 
  z = LesePos();           % Messwerte lesen    
  [pos vel] = DvKalman(z); % Kalman-Filter
  
  %% Werte speichern
  Xsaved(k, :) = [pos vel];
  Zsaved(k)    = z;
end


figure
hold on
plot(t, Zsaved(:), 'r.')
plot(t, Xsaved(:, 1))
legend('Positionsmesswerte','Kalman-Filter Schätzung','Location','SE')
xlabel('Abtastzeit in s')
ylabel('Position in m')


figure
hold on
line([0 10],[80 80],'Color',[0.7 0.7 0.7],'LineWidth',2)
plot(t, Xsaved(:, 2))
legend('Wahre Geschwindigkeit','Kalman-Filter Schätzung','Location','SE')
xlabel('Abtastzeit in s')
ylabel('Geschätzte Geschwindigkeit in m/s')
