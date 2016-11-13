%****************************************************************
%        Hochschule Hamm-Lippstadt                              *
%****************************************************************
% Modul			  : TestDvKalmanUltraschall.m                         *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Kalman Filter für die Geschwindigkeits-     *
%                   schätzung bei einer Höhenmessung            *
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

global dt
dt = 0.02;                    % Abtastzeit in s
nSamples = 500;               % Anzahl der Messwerte
t  = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

%% Speicherplatz reservieren
Xsaved = zeros(nSamples, 2);
Zsaved = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
  z = LeseUltraschall();    % Messwerte lesen   
  [pos vel] = DvKalman(z);  % Kalman-Filter
  
  %% Werte speichern
  Xsaved(k, :) = [pos vel];
  Zsaved(k)    = z;
end

figure
hold on
plot(t, Zsaved(:), 'r.')
plot(t, Xsaved(:, 1))
legend('Messwerte', 'Kalman-Filter Schätzung','Location','Best')
xlabel('Zeit in s')
ylabel('Distanz in m')


figure
%% Farbe der Axe
co = [0    0  0
    0.5  0.5  0.5
    0.6  0.4  0.6
    0.4  0.6  0.7
    0.2  0.8  0.8
      0    1  0.9];
set(groot,'defaultAxesColorOrder',co)

[Ax, H1, H2] = plotyy(t, Zsaved(:), t, Xsaved(:, 2)); % Plot mit zwei y-Achsen
legend('Position', 'Geschwindigkeit','Location','Best')
xlabel('Zeit in s')
set(get(Ax(1),'Ylabel'),'String','Flughöhe in m','Color',[0 0 0])
set(get(Ax(2),'Ylabel'),'String','Geschwindigkeit in m/s')
set(H1,'LineStyle','-','Color',[0 0 0])
set(H2,'LineStyle','-','Color',[0.5 0.5 0.5])
