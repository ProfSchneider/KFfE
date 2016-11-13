%****************************************************************
% Modul			  : EulerEKF.m                                  *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Sensordatenfusion mittels EKF               *
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

function [phi theta psi] = EulerEKF(z, rates, dt)
%
%
persistent H Q R
persistent x P
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  H = [ 1 0 0;
        0 1 0 ];
  
  Q = [ 0.0001 0      0;
        0      0.0001 0;
        0      0      0.1 ];
     
  R = [  6  0;
         0  6 ];

  x = [0 0 0]';  
  P = 10*eye(3);
  
  bErsterDurchlauf = 1;  
end

%% Prädiktion
A = Ajacob(x, rates, dt); % Jacobi-Matrix berechnet Linearisierung im AP

xp = fx(x, rates, dt);    % Prädiktion des Zustandsvektors
Pp = A*P*A' + Q;

%% Schätzung
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;

%% Rückgabewerte 
phi   = x(1);
theta = x(2);
psi   = x(3);


%------------------------------
function xp = fx(xhat, rates, dt)
%
%
phi   = xhat(1);
theta = xhat(2);

p = rates(1);
q = rates(2);
r = rates(3);

xdot = zeros(3, 1);
xdot(1) = p + q*sin(phi)*tan(theta) + r*cos(phi)*tan(theta);
xdot(2) =     q*cos(phi)            - r*sin(phi);
xdot(3) =     q*sin(phi)*sec(theta) + r*cos(phi)*sec(theta);

xp = xhat + xdot*dt; % Prädiktion des Zustandsvektors


%------------------------------
function A = Ajacob(xhat, rates, dt)
%
%
A = zeros(3, 3);


phi   = xhat(1);
theta = xhat(2);

p = rates(1);
q = rates(2);
r = rates(3);

A(1,1) = q*cos(phi)*tan(theta)   - r*sin(phi)*tan(theta);
A(1,2) = q*sin(phi)*sec(theta)^2 + r*cos(phi)*sec(theta)^2;
A(1,3) = 0;

A(2,1) = -q*sin(phi) - r*cos(phi);
A(2,2) = 0;
A(2,3) = 0;

A(3,1) = q*cos(phi)*sec(theta)            - r*sin(phi)*sec(theta);
A(3,2) = q*sin(phi)*sec(theta)*tan(theta) + r*cos(phi)*sec(theta)*tan(theta);
A(3,3) = 0;

A = eye(3) + A*dt; % Linearisierung im AP