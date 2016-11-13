%****************************************************************
% Modul			  : TestTrackKalmanQR.m                         *
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
% Letzte Änderung : 13. November 2016                           *
%                                                               *
%***************************************************************/

clear all; close all; clc; % MATLAB vorbereiten

nAnzahlBilder = 24; % max. 24 Bilder

%% Speicherplatz reservieren
Xmsaved  = zeros(2, nAnzahlBilder);
Xhsaved  = zeros(2, nAnzahlBilder);
Xqrsaved = zeros(2, nAnzahlBilder);

%% Schleife über alle Messwerte
for k = 1:nAnzahlBilder
  [xm,   ym] = BestimmeBallPos(k);    % Bildverarbeitung liefert Messwerte
  [xh,   yh] = TrackKalman(xm, ym);   % 2D-Kalman-Filter
  [xqr, yqr] = TrackKalmanQR(xm, ym); % Q, R verändert
      
  hold on % Zwischenergebnis visualisieren
  plot(xm,  ym,  'r*') % Messwert
  plot(xh,  yh,  'bs') % Q
  plot(xqr, yqr, 'bo') % 0,01*Q
  
  pause(1) % Abtastzeit 1s
  
  %% Werte speichern
  Xmsaved(:, k)  = [xm   ym]';
  Xhsaved(:, k)  = [xh   yh]';
  Xqrsaved(:, k) = [xqr, yqr];
end


figure
hold on
line([0 350],[250 0],'Color',[0.5 0.5 0.5],'LineWidth',2) % Wahrer Wert
%plot(Xmsaved(1,:),  Xmsaved(2,:),  '*') % Messwert bei Bedarf einblenden
plot(Xhsaved(1,:),  Xhsaved(2,:),  's')
plot(Xqrsaved(1,:), Xqrsaved(2,:), 'o')
legend('Wahrer Wert','Q','0,01*Q','Location','Best')
xlabel('x in Pixel')
ylabel('y in Pixel')
set(gca,'yDir','reverse')

