%****************************************************************
% Modul			  : HPF.m                                       *
%				                            					*
% Datum           : 13-Jan-2014                                 *
%                                                               *
% Funktion        : Einfaches Hochpassfilter                    *
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

function xhpf = Hochpass(u)
%
%
global dt;

persistent prevX
persistent prevU
persistent tau
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  prevX = 0;
  prevU = 0;
  tau   = 0.0233; % s variiert selten während der Filterausführung, daher CONST
  
  bErsterDurchlauf = 1;  
end

%% Zeitdiskretes Hochpassfilter
alpha = tau / (tau + dt); % 0,7
xhpf = alpha*prevX + alpha*(u - prevU); % Hochpassgleichung

prevX = xhpf;
prevU = u;