%****************************************************************
% Modul			  : TestEulerKalman.m                           *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Lagebestimmung mit Kalman-Filter            *
%                   (Startfunktion)                             *
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

dt = 0.01;                   % Abtastzeit in s
nSamples = 41500;            % Anzahl der Messwerte
t = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

EulerSaved = zeros(nSamples, 3); % Speicherplatz reservieren

%% Schleife über alle Messwerte
for k=1:nSamples
  [p q r] = LeseGyro();  % Gyro Messwerte einlesen
  A = eye(4) + dt*1/2*[ 0  -p  -q  -r;
                        p   0   r  -q;
                        q  -r   0   p;
                        r   q  -p   0
                      ]; % Zustandsübergangsmatrix

  [ax ay] = LeseAccel(); % Acc. Messwerte einlesen                
  [phi theta] = EulerAccel(ax, ay);       % Beschl. in Eulerwinkel umrechnen
  z = EulerInQuaternionen(phi, theta, 0); % Eulerwinkel in Quaternionen umrechnen

  [phi theta psi] = EulerKalman(A, z);    % Kalman-Filter
  
  EulerSaved(k, :) = [ phi theta psi ];   % Werte speichern
end 

%% Umrechnung rad in deg
PhiSaved   = EulerSaved(:, 1) * 180/pi;
ThetaSaved = EulerSaved(:, 2) * 180/pi;
PsiSaved   = EulerSaved(:, 3) * 180/pi;

figure
plot(t, PhiSaved)
xlabel('Zeit in s')
ylabel('Rollwinkel \phi in deg')

figure
plot(t, ThetaSaved)
xlabel('Zeit in s')
ylabel('Nickwinkel \theta in deg')

figure
plot(t, PsiSaved)
xlabel('Zeit in s')
ylabel('Gierwinkel \psi in deg')