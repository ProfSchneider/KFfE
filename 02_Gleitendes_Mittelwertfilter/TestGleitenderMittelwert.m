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
% Bemerkung       : https://github.com/philbooks/               *
%                                                               *
% Letzte �nderung : 23. September 2016                          *
%                                                               *
%***************************************************************/

clear all; close all; clc % Matlab vorbereiten


nSamples = 1500; % Anzahl der Messwerte max 1501 (Default: 500)
% Speicherplatz reservieren
aXsaved   = zeros(nSamples, 1);
aXmsaved  = zeros(nSamples, 1);

% Schleife �ber alle Messwerte
for k=1:nSamples
  xm = LeseUltraschall(); 
  %x  = RekGleitenderMittelwert(xm); % rekursive Funktion
  x  = GleitenderMittelwert(xm);
  
  aXsaved(k)  = x;
  aXmsaved(k) = xm;
end

% Zeitachse zeichnen
dt = 0.02;                %Abtastzeit
t  = 0:dt:nSamples*dt-dt;

figure
hold on
plot(t, aXmsaved, 'r.');
plot(t, aXsaved, 'b');

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



