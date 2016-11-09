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

clear all; close all; clc

%% Initialisierung
dt = 0.2;
t  = 0:dt:10;

Nsamples = length(t);

%% Ergebnisvektoren
aMittelwert = zeros(Nsamples, 1);
aXm  = zeros(Nsamples, 1);  

%% Hauptschleife
for k=1:Nsamples
  xm  = LeseSpannung(); % Zufallswerte laden
  Mittelwert = RekursiverMittelwert(xm);
  
  % Messwerte speichern
  aMittelwert(k) = Mittelwert;
  aXm(k)  = xm;
end


figure(1)
plot(t, aXm, 'r:*')
hold on
plot(t, aMittelwert, 'o-')
line([0,10],[14.4,14.4],'Color',[.5 .5 .5])
xlabel('Zeit in s')
ylabel('Spannung in V')
legend('Messwerte','Rekursiver Mittelwert','14,4V','Location','Best')

disp(['Das letzte Ergebnis des rekursiven Mittelwertes: ',num2str(aXm(k)),' V'])
disp('Wahre Wert: 14,4V')
