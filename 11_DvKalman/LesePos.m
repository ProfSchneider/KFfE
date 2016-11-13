%****************************************************************
% Modul			  : LesePos.m                                   *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Simulation der Zugbewegung                  *
%                   R�ckgabe der Position                       *
%                                                               *
% Implementation  : MATLAB 2016a                  			    *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte �nderung : 13. September 2016                          *
%                                                               *
%***************************************************************/

function z = LesePos()
%
%
global dt % Abtastzeit in s
persistent Velp Posp

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(Posp)
  Posp = 0;  % in m
  Velp = 80; % in m/s
end

w  = 0 + 10*randn; % Systemrauschen in m/s
v  = 0 + 10*randn; % Messrauschen in m

z = Posp + Velp*dt + v; % Pos. als R�ckgabewert

Posp = z - v;     % Wahre Position in m
Velp = 80 + w;    % Wahre Geschwindigkeit incl. Rauschen in m/s