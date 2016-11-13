%****************************************************************
% Modul			  : TrackKalman.m                               *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : 2D-Kalman Filter                            *
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

function [xh yh] = TrackKalman(xm, ym)
%
%
persistent A H Q R
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  dt = 1; % Abtastzeit in s
  A = [ 1  dt  0   0
        0  1   0   0
        0  0   1  dt
        0  0   0   1 ];
  
  H = [ 1  0  0  0
        0  0  1  0 ];
 
  Q = 1.0*eye(4);
  R = [ 50  0
         0 50 ];

  x = [0, 0, 0, 0]';
  P = 100*eye(4);
  
  bErsterDurchlauf = 1;
end

%% Prädiktion 
xp = A*x;
Pp = A*P*A' + Q;

%% Schätzung
K = Pp*H'*inv(H*Pp*H' + R);

z = [xm ym]'; % Messwerte
x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;

%% Rückgabewerte
xh = x(1); % x-Position
yh = x(3); % y-Position