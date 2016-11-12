%****************************************************************
% Modul	          : TestRekursiverMittelwert                    *
%                                                               *
% Datum           : 13. September 2016                          *
%                                                               *
% Funktion        : Berechnung eines rekursiven Mittelwertes    *
%                   Testfunktion                                *
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

clear all; close all; clc; % MATLAB vorbereiten

dt = 0.2;      % Abtastzeit in s
t  = 0:dt:10;  % Zeitachse als Array
nSamples = length(t); % Anz. der Messwerte

% Speicherplatz reservieren
aMittelwert = zeros(nSamples, 1);
aXm  = zeros(nSamples, 1);  

%%  Hauptschleife über alle Messwerte
for k=1:nSamples
  xm         = LeseSpannung(); % Messung
  Mittelwert = RekursiverMittelwert(xm); % Filter
  
  % Messwerte speichern
  aMittelwert(k) = Mittelwert;
  aXm(k)         = xm;
end

figure
hold on
plot(t, aXm, 'r:.')
plot(t, aMittelwert, 'o-')
line([0,10],[14.4,14.4],'Color',[.5 .5 .5])
xlabel('Zeit in s')
ylabel('Spannung in V')
legend('Messwerte','Rekursiver Mittelwert','14,4V','Location','Best')

disp(['Das letzte Ergebnis des rekursiven Mittelwertes: ',num2str(aXm(k)),' V'])
disp('Wahre Wert: 14,4V')
