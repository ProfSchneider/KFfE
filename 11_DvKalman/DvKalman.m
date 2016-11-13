%****************************************************************
% Modul		      : DvKalman.m                                  *
%				                            	                *
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Kalman-Filter f�r die Geschwindigkeits-     *
%                   sch�tzung eines Zuges                       *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte �nderung : 13. September 2016                          *
%                                                               *
%***************************************************************/

function [pos vel] = DvKalman(z)
%
%
global dt % Abtastzeit in s
persistent A H Q R 
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  A = [ 1 dt;   % Systemmatrix
        0 1 ];
  H = [ 1 0 ];  % Messmatrix
  
  Q = [ 1 0;    % Systemrauschen
        0 3 ];
  R = 10;       % Messrauschen

  x = [ 0 20 ]';% initiale Zustandssch�tzung x0=0m v0=20m/s
  P = 5*eye(2); % initiale Fehlerkovarianzmatrix
  
  bErsterDurchlauf = 1;
end

%% Pr�diktion  
xp = A*x;  
Pp = A*P*A' + Q;    

%% Sch�tzung
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;   

%% R�ckgabewerte
pos = x(1);
vel = x(2);