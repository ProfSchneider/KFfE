%****************************************************************
% Modul		  : RadarEKF.m                                  *
%				                                *
% Datum           : 16-Dez-2013                                 *
%                                                               *
% Funktion        : Extended Kalman-Filter                      *
%                   für 14.4 Beispiel 1: Radar-Tracking         *
%                                                               *
% Implementation  : MATLAB 2016a                  		*
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

function [pos vel alt] = RadarEKF(z, dt)
% Eingänge
% z:  Messvektor
% dt: Zeitscheibe

% Ausgänge sind skalare Größen
% pos: x Position in m
% vel: Geschwindigkeit in m/s als konstant angenommen
% alt: Höhe in m als konstant angenommen
persistent A Q R
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  A = eye(3) + dt*[ 0 1 0;
                    0 0 0;
                    0 0 0 ];    
  Q = [ 0  0      0;
        0  0.001  0;
        0  0      0.001 ];
     
  R = 10;

  x = [0 90 1100]';  % Startwerte sind äußerst wichtig
  P = 10*eye(3);
  
  bErsterDurchlauf = 1;  
end

%% Prädiktion
xp = A*x;
Pp = A*P*A' + Q;

%% Schätzung
H = Hjacob(xp); % Jacobi-Matrix berechnet Linearisierung im AP
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - hx(xp));
P = Pp - K*H*Pp;

%% Rückgabewerte  
pos = x(1);
vel = x(2);
alt = x(3);


%------------------------------
function zp = hx(xp)
% Nichtlineares Systemmodell C*xp 
% Ausgang zp: Prädizierte Messung
x1 = xp(1); % Horizontale Entfernung in m
x3 = xp(3); % Objekthöhe in m

zp = sqrt(x1^2 + x3^2); % prädizierte Schrägentfernung zum Objekt

%% ------------------------------
function H = Hjacob(xp)
% Unterfunktion Jacobi-Matrix des Messmodells H

% Eingang xp: Prädizierte Zustandsvariable
% Ausgang  H: Messmatrix
H = zeros(1, 3);

x1 = xp(1); % Horizontale Entfernung in m
x3 = xp(3); % Objekthöhe in m

%% Partielle Ableitungen
H(1) = x1 / sqrt(x1^2 + x3^2);
H(2) = 0;
H(3) = x3 / sqrt(x1^2 + x3^2);