%****************************************************************
% Modul			  : TestRadarEKF.m                              *
%				                            					*
% Datum           : 16-Dez-2013                                 *
%                                                               *
% Funktion        : Startfunktion der Simulation der Radardaten *
%                   für ein Radar EKF                           *
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

dt = 0.05;                   % Abtastzeit in s
nSamples = 401;              % Anzahl der Messwerte
t = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

%% Speicherplatz reservieren
Xsaved = zeros(nSamples, 3);
Zsaved = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
  r = LeseRadar(dt);               % Messwerte lesen
  [pos vel alt] = RadarEKF(r, dt); % Extended Kalman-Filter
  
  %% Werte speichern
  Xsaved(k, :) = [pos vel alt];
  Zsaved(k)    = r;
  zp(k)        = sqrt(pos^2+alt^2);
end 

PosSaved = Xsaved(:, 1);
VelSaved = Xsaved(:, 2);
AltSaved = Xsaved(:, 3);

vw = 100;  % wahre Geschwindigkeit = 100 m/s
hw = 1000; % wahre Höhe

figure
hold on
line([0 20],[0 2000],'Color',[1 0 0])
plot(t, PosSaved)
legend('Wahrer Wert','EKF Schätzung','Location','Best')
xlabel('Zeit in s')
ylabel('x-Position in m')


figure
hold on
line([0 20],[100 100],'Color',[1 0 0])
plot(t, VelSaved)
xlabel('Zeit in s')
ylabel('Geschwindigkeit in m/s')
legend('Wahrer Wert','EKF Schätzung','Location','Best')

figure
hold on
line([0 20],[1000 1000],'Color',[1 0 0])
plot(t, AltSaved)
xlabel('Zeit in s')
ylabel('Höhe in m')
legend('Wahrer Wert','EKF Schätzung','Location','Best')

figure
hold on
plot(t, Zsaved,'r-')
plot(t, zp,'b-')
xlabel('Zeit in s')
ylabel('Schrägentfernung in m')
legend('Simulierte Messwerte','EKF Schätzung','Location','Best')
