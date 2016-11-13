%****************************************************************
%        Hochschule Hamm-Lippstadt                              *
%****************************************************************
% Modul			  : TestHPF.m                                   *
%				                            					*
% Datum           : 13-Jan-2014                                 *
%                                                               *
% Funktion        : Testfunktion für Hochpassfilter             *
%                                                               *
% Implementation  : MATLAB 2013a                  			    *
%                                                               *
% Author		  : Prof. Dr. U. Schneider     				    *
%                   basierend auf dem Programm von              *
%                   Phil Kim                                    *
% Bemerkung       : 											*
%                                                               *
% Letzte Änderung : 13. Jan. 14                                 *
%                                                               *
%***************************************************************/

clear all; close all; clc; % MATLAB vorbereiten

global dt;
dt = 0.02;                    % Abtastzeit in s
nSamples = 500;               % Anzahl der Messwerte max. 1501 (Default: 500)
t  = 0:dt:(nSamples*dt - dt); % Zeitachse als Array

%% Speicherplatz reservieren
Xsaved   = zeros(nSamples, 1);
Xmsaved  = zeros(nSamples, 1);

%% Schleife über alle Messwerte
for k=1:nSamples
    
  zm = LeseUltraschall(); % Messung laden
  x  = Hochpass(zm);      % Hochpassfilter
  
  %% Messwerte speichern
  Xsaved(k)  = x;
  Xmsaved(k) = zm;
end

figure
hold on
plot(t, Xmsaved, 'r.');
plot(t, Xsaved, 'b')
xlabel('t in s')
ylabel('Flughöhe in m')
legend('Messung', 'HPF','Location','best')

figure
hold on
plot(t, Xmsaved, 'r.');
plot(t, Xmsaved-Xsaved, 'b')
xlabel('t in s')
ylabel('Flughöhe in m')
legend('Messung', 'Messung-HPF','Location','best')
