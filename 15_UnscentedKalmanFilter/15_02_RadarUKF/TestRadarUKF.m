%****************************************************************
% Modul			  :     TestRadarUKF.m                              *
%				                            				                  	*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Startfunktion der Simulation der Radardaten *
%                   für ein Radar UKF                           *
%                                                               *
% Implementation  : MATLAB 2016a                  			        *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 21. November 2021                           *
%                                                               *
%***************************************************************/

clear all; close all; clc; % MATLAB vorbereiten

dt = 0.05;                    % Abtastzeit in s
nSamples = 401;               % Anzahl der Messwerte
t = 0:dt:(nSamples*dt - dt);  % Zeitachse als Array

%% Speicherplatz reservieren
Xsaved = zeros(nSamples, 3);
Zsaved = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
  r = LeseRadar(dt);               % Messdaten laden
  [pos vel alt] = RadarUKF(r, dt); % UKF
  
  %% Werte speichern
  Xsaved(k, :) = [pos vel alt];
  Zsaved(k)    = r;
end 

PosSaved = Xsaved(:, 1);
VelSaved = Xsaved(:, 2);
AltSaved = Xsaved(:, 3);

figure
hold on
line([0 20],[0 2000],'Color',[1 0 0])
plot(t, PosSaved)
legend('Wahrer Wert','EKF Schätzung','Location','Best')
xlabel('Zeit in s')
ylabel('Horizontale Entfernung in m')
legend('Wahrer Wert','UKF Schätzung','Location','Best')

figure
hold on
line([0 20],[100 100],'Color',[1 0 0])
plot(t, VelSaved)
xlabel('Zeit in s')
ylabel('Horizontale Geschwindigkeit in m/s')
legend('Wahrer Wert','UKF Schätzung','Location','Best')

figure
hold on
line([0 20],[1000 1000],'Color',[1 0 0])
plot(t, AltSaved)
xlabel('Zeit in s')
ylabel('Schrägentfernung in m')
ylabel('Höhe in m')
legend('Wahrer Wert','UKF Schätzung','Location','Best')
ylim([990 1050])
