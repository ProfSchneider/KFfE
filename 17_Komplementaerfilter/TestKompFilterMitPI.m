%****************************************************************
% Modul	          : TestKompFilterMitPI()                       *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Startfunktion des Komplementärfilters       *
%                                                               *
% Implementation  : MATLAB R2016a                               *
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

dt = 0.01;                    % Abtastzeit in s
nSamples = 41500;             % Anzahl der Messwerte
t  = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

EulerSaved = zeros(nSamples, 3); % Speicherplatz reservieren

%% Schleife über alle Messwerte
for k = 1:nSamples 
  [ax ay] = LeseAccel();   % Gyro Messwerte einlesen
  [p q r] = LeseGyro();    % Acc. Messwerte einlesen
  [phi theta psi] = KompFilterMitPI(p, q, r, ax, ay, dt); % Komplementärfilter
  
  %% Messwerte speichern
  EulerSaved(k, :) = [phi theta psi];
end 

%% Umrechnung rad in deg
PhiSaved   = EulerSaved(:, 1) * 180/pi;
ThetaSaved = EulerSaved(:, 2) * 180/pi;
PsiSaved   = EulerSaved(:, 3) * 180/pi;


figure
plot(t, PhiSaved,'k-')
xlabel('Zeit in s')
ylabel('Rollwinkel \phi in deg')

figure
plot(t, ThetaSaved,'k-')
xlabel('Zeit in s')
ylabel('Nickwinkel \theta in deg')

figure
plot(t, PsiSaved,'k-')
xlabel('Zeit in s')
ylabel('Gierwinkel \psi in deg')