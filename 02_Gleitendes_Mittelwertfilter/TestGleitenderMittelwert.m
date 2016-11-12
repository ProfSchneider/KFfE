%****************************************************************
% Modul	          : TestGleitenderMittelwert(x)                 *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Berechnung eines rekursiven Mittelwertes    *
%                   Startfunktion                               *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 23. September 2016                          *
%                                                               *
%***************************************************************/

clear all; close all; clc % MATLAB vorbereiten

nSamples = 1500; % Anzahl der Messwerte max. 1501 (Default: 500)

% Speicherplatz reservieren
aXsaved   = zeros(nSamples, 1);
aXmsaved  = zeros(nSamples, 1);

% Schleife über alle Messwerte
for k=1:nSamples
  xm = LeseUltraschall(); % Messung laden
  %x  = RekGleitenderMittelwert(xm); % rekursive Funktion
  x  = GleitenderMittelwert(xm); % Filter
  
  % Messwerte speichern
  aXsaved(k)  = x;
  aXmsaved(k) = xm;
end

dt = 0.02;                    % Abtastzeit in s
t  = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

figure
hold on
plot(t, aXmsaved, 'r.');
plot(t, aXsaved, 'b-');

xlabel('Zeit in s')
ylabel('Distanz in m')
legend('Messwert', 'Gleitender Mittelwert')

figure
hold on
plot(t, aXmsaved, 'r.');
plot(t, aXsaved, 'b');

xlabel('Zeit in s')
ylabel('Distanz in m')
xlim([1 500*dt])
legend('Messwert', 'Gleitender Mittelwert','Location','NW')



