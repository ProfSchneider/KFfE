%****************************************************************
% Modul           : RadarUKF.m                                  *
%		                                                            *
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Unscented Kalman-Filter                     *
%                                                               *
% Implementation  : MATLAB 2016a                  			        *
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
%****************************************************************
% Modul			  : RadarUKF.m                                  *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Unscented Kalman-Filter                     *
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

function [pos vel alt] = RadarUKF(z, dt)
%
%
persistent Q R
persistent x P
persistent n m
persistent bErsterDurchlauf 

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf )
  Q = [ 0.01  0      0;
        0  0.01  0;
        0  0      0.01 ];
     
  R = 100;

  x = [0 90 1100]';  
  P = 100*eye(3);

  n = 3;
  m = 1;
  
  bErsterDurchlauf  = 1;  
end

%% Prädiktion
[Xi W] = SigmaPunkte(x, P, 0); % 1. Berechnung der Sigma-Punkte und Gewichte

fXi = zeros(n, 2*n+1);
for k = 1:2*n+1
  fXi(:, k) = fx(Xi(:,k), dt);
end

[xp Pp] = UT(fXi, W, Q); % 2. Vorhersage des Zustandsvektors und der Kovarianz


%% Schätzung
hXi = zeros(m, 2*n+1);
for k = 1:2*n+1
  hXi(:, k) = hx(fXi(:,k));
end

[zp Pz] = UT(hXi, W, R); % 3. Vorhersage des Messvektors und der Kovarianz
%norm(zp - hx(xp))

Pxz = zeros(n, m);
for k = 1:2*n+1
  Pxz = Pxz + W(k)*(fXi(:, k) - xp)*(hXi(:, k) - zp)';
end

K = Pxz*inv(Pz);     % 4. Berechnung der Kalman-Verstärkung

x = xp + K*(z - zp); % 5. Korrektur der Zustandsschätzung
P = Pp - K*Pz*K';    % 6. Korrektur der Kovarianzschätzung

%% Rückgabewerte 
pos = x(1);
vel = x(2);
alt = x(3);


%------------------------------
function xp = fx(x, dt)
%
%
A = eye(3) + dt*[ 0 1 0;
                  0 0 0;
                  0 0 0 ];  

xp = A*x; % Prädiktion



%------------------------------
function yp = hx(x)
%
%
yp = sqrt(x(1)^2 + x(3)^2);
