%****************************************************************
% Modul			  : SimpleKalman.m               	            *
%				                            					*
% Datum           : 13. September 2016                          *
%                                                               *
% Funktion        : Kalman-Filter Algorithmus                   *
%                                                               *
% Implementation  : MATLAB 2013a                  			    *
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

function [Spannung Cov Kg] = SimpelKalman2(z)
%
%
persistent A C Q R 
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  A = 1; % Systemmatrix der linearen Zustandsraumdarstellung
  C = 1; % Ausgangsmatrix der linearen Zustandsraumdarstellung
  
  Q = 0; % Kovarianzmatrix des Systemrauschens
  R = 4; % Kovarianzmatrix des Messrauschens

  x = 14; % in V, initiale Sch�tzung
  P =  6; % Kovarianzmatrix des Sch�tzfehlers
  
  bErsterDurchlauf = 1;  
end

%% Pr�diktionsprozess 
% 1. Vorhersage des Zustandsvektors und der Kovarianz
xp = A*x;            % Pr�diktion der Sch�tzung
Pp = A*P*A' + Q;     % Pr�diktion der Fehlerkovarianz

%% Sch�tzprozess
% 2. Berechnung der Kalman-Verst�rkung K
K = Pp*C'*inv(C*Pp*C' + R);

% 3. Korrektur der Zustandssch�tzung
x = xp + K*(z - C*xp);

% 4. Korrektur der Kovarianzsch�tzung
P = Pp - K*C*Pp;

%% R�ckgabewerte
Spannung = x;
Cov      = P;
Kg       = K;