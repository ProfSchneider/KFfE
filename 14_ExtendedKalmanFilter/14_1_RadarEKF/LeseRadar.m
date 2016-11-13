%****************************************************************
% Modul			  : LeseRadar.m                                 *
%				                            					*
% Datum           : 16-Dez-2013                                 *
%                                                               *
% Funktion        : Simulation der Radardaten                   *
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

function r = LeseRadar(dt)
%
%
persistent posp

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(posp)
  posp = 0;
end

%% Verrauschte Objektposition und Geschwindigkeit
vel = 100  +  5*randn; % konstante Objektgeschwindigkeit in m/s
alt = 1000 + 10*randn; % Objektposition in m

pos = posp + vel*dt; % Physikalische Bewegung mit konstanter Geschwindigkeit

%% Messrauschen
v = 0 + pos*0.05*randn; % 5% der Messung

%% Radarmessung ist der Rückgabewert
r = sqrt(pos^2 + alt^2) + v; % Euklidische Distanz + Messrauschen

posp = pos; % Zwischenspeicherung der Position(k)