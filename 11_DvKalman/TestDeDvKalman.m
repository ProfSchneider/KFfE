%****************************************************************
%        Hochschule Hamm-Lippstadt                              *
%****************************************************************
% Modul			  : TestDeDvKalmanSonar.m                       *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Kalman Filter für die Geschwindigkeits-     *
%                   schätzung bei einer Höhenmessung            *
%                   Vergleich beider Kalman-Filter              *
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

nSamples = length(t);  % Anzahl der Messwerte

%% Speicherplatz reservieren
Xsaved   = zeros(nSamples, 2);
DeXsaved = zeros(nSamples, 2);
Zsaved   = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
  z = LesePos();               % Messwerte lesen
  [pos vel]   = DvKalman(z);   % Inverse Matrizenrechnung
  [dpos dvel] = DeDvKalman(z); % Effiziente K-Berechnung
  
  %% Werte speichern
  Xsaved(k, :)   = [pos vel];
  DeXsaved(k, :) = [dpos dvel]; 
  Zsaved(k)      = z;
end


figure
hold on
plot(t, Xsaved(:, 1), 'ro')
plot(t, DeXsaved(:,1))
legend('Inverse Matrizenrechnung', 'Effiziente Verstärkungsberechnung','Location','Best')
xlabel('t in s')
ylabel('Geschwindigkeit in m/s')

figure
hold on
plot(t, Xsaved(:, 2), 'ro')
plot(t, DeXsaved(:,2))
legend('Inverse Matrizenrechnung', 'Effiziente Verstärkungsberechnung','Location','Best')
ylabel('Geschwindigkeit in m/s')
xlabel('Zeit in s')
