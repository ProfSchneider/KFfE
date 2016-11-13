%****************************************************************
% Modul			  : IntKalman.m                                 *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Kalman-Filter für die Positionsschätzung    *
%                   eines Zuges anhand der Geschwindigkeits     *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 13. September 2016                          *
%                                                               *
%***************************************************************/
function [pos vel] = IntKalman(z)
%
%
global dt % Abtastzeit in s
persistent A H Q R 
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  A = [ 1 dt;
        0 1 ];
  H = [ 0 1 ]; % ÄNDERUNG! Geschwindigkeitsmessung anstelle der Pos. [1 0]
  
  Q = [ 1 0;
        0 3 ];
  R = 10;

  x = [ 0 20 ]';
  P = 5*eye(2);
  
  bErsterDurchlauf = 1;
end

%% Prädiktion  
xp = A*x;  
Pp = A*P*A' + Q;    

%% Schätzung
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;   

%% Rückgabewerte
pos = x(1);
vel = x(2);