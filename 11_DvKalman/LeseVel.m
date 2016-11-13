%****************************************************************
% Modul			  : LeseVel.m                                   *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Simulation der Zugbewegung                  *
%                   Rückgabe der Geschwindigkeit                *
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

function z = LeseVel()
%
%
global dt % Abtastzeit in s
persistent Velp Posp

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(Posp)
  Posp = 0;  % in m
  Velp = 80; % in m/s
end

v  = 0 + 10*randn; % Messrauschen in m/s

Posp = Posp + Velp*dt;     % Wahre Position in m
Velp = 80 + v;             % Wahre Geschwindigkeit incl. Rauschen in m/s

z = Velp; % Geschwindigkeit als Rückgabewert
