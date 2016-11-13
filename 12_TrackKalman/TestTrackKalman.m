%****************************************************************
% Modul			  : TestTrackKalman.m                           *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : 2D-Kalman Filter (Startfunktion)            *
%                                                               *
% Implementation  : MATLAB 2016a                  			    *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte �nderung : 13. November 2016                           *
%                                                               *
%***************************************************************/

clear all; close all; clc; % MATLAB vorbereiten

nAnzahlBilder = 24; % max. 24 Bilder verf�gbar

%% Speicherplatz reservieren
Xmsaved = zeros(2, nAnzahlBilder);
Xhsaved = zeros(2, nAnzahlBilder);

%% Schleife �ber alle Messwerte
for k = 1:nAnzahlBilder
  [xm, ym] = BestimmeBallPos(k);    % Bildverarbeitung liefert Messwerte
  [xh, yh] = TrackKalman(xm, ym);   % 2D-Kalman-Filter
      
  hold on % Zwischenergebnis visualisieren
  plot(xm, ym, 'r*')
  plot(xh, yh, 'bs')
  
  pause(1) % Abtastzeit 1s
  
  %% Werte speichern
  Xmsaved(:, k) = [xm ym]';
  Xhsaved(:, k) = [xh yh]';
end


figure
hold on
plot(Xmsaved(1,:), Xmsaved(2,:), '*')
plot(Xhsaved(1,:), Xhsaved(2,:), 's')
legend('Messwerte','Kalman-Filter Sch�tzung','Location','Best')
xlabel('x in Pixel')
ylabel('y in Pixel')
set(gca,'yDir','reverse')

