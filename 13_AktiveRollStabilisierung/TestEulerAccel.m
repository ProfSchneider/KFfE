%****************************************************************
% Modul			  : TestEulerAccel.m                             *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Lagebestimmung mit Gyros (Startfunktion)    *
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

dt = 0.01;                   % Abtastzeit in s
nSamples = 41500;            % Anzahl der Messwerte
t = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

EulerSaved = zeros(nSamples, 2); % Speicherplatz reservieren

%% Schleife �ber alle Messwerte
for k = 1:nSamples
  [ax ay] = LeseAccel();            % Messwerte lesen
  [phi theta] = EulerAccel(ax, ay); % Umrechnung in Eulerwinkel
  
  EulerSaved(k, :) = [phi theta];   % Werte speichern
end 

%% Umrechnung rad in deg
PhiSaved   = EulerSaved(:, 1) * 180/pi;
ThetaSaved = EulerSaved(:, 2) * 180/pi;

figure
plot(t, PhiSaved)
xlabel('Zeit in s')
ylabel('Rollwinkel \phi in deg')

figure
plot(t, ThetaSaved)
xlabel('Zeit in s')
ylabel('Nickwinkel \theta in deg')