%****************************************************************
%        Hochschule Hamm-Lippstadt                              *
%****************************************************************
% Modul			  : TestIntKalman.m                             *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Start-Skript für die Positionsschätzung     *
%                   eines Zuges anhand der Geschwindigkeits-    *
%                   messung                                     *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
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

%% Speicherplatz reservieren
Xsaved = zeros(nSamples, 2); 
Zsaved = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
  z = LeseVel();            % Messwerte lesen  
  [pos vel] = IntKalman(z); % Kalman-Filter
  
  %% Werte speichern
  Xsaved(k, :) = [pos vel];
  Zsaved(k)    = z;
end


figure
plot(t, Xsaved(:, 1))
legend('Kalman-Filter Schätzung')
xlabel('Zeit in s')
ylabel('Position in m')


figure
hold on
plot(t, Zsaved(:), 'r.')
plot(t, Xsaved(:, 2),'LineWidth',1.5)
legend('Messwerte','Kalman-Filter Schätzung')
xlabel('Zeit in s')
ylabel('Geschwindigkeit in m/s')
