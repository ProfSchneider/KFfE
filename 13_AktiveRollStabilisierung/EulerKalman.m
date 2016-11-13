%****************************************************************
% Modul			  : EulerKalman.m                               *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Sensordatenfusion mittels Kalman-Filter     *
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

function [phi theta psi] = EulerKalman(A, z)
%
%
persistent H Q R
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  H = eye(4);
  
  Q = 0.0001*eye(4);
  R = 10*eye(4);

  x = [1 0 0 0]';  
  P = 1*eye(4);
  
  bErsterDurchlauf = 1;  
end

%% Prädiktion 
xp = A*x;
Pp = A*P*A' + Q;

%% Schätzung
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);     % x = [ q1 q2 q3 q4 ]
P = Pp - K*H*Pp;

%% Rückgabewerte
phi   =  atan2( 2*(x(3)*x(4) + x(1)*x(2)), 1 - 2*(x(2)^2 + x(3)^2) );
theta = -asin(  2*(x(2)*x(4) - x(1)*x(3)) );
psi   =  atan2( 2*(x(2)*x(3) + x(1)*x(4)), 1 - 2*(x(3)^2 + x(4)^2) );