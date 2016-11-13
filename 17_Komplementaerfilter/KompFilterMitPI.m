%****************************************************************
% Modul	          : KompFilterMitPI()                           *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Beispielskript zur Berechnung der zeit-     *
%                   diskreten Übertragungsfunktion mit c2dm     *
%                                                               *
% Unterfunktion   : KoerperfestZuInertial                       *
%                   Koordinatentransformation vom körperfesten  *
%                   zum inertialen KOS                          *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 09. November 2016                           *
%                                                               *
%***************************************************************/

function [phi theta psi] = KompFilterMitPI(p, q, r, ax, ay, dt)
%
%
persistent p_hat q_hat
persistent prevPhi prevTheta prevPsi

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(p_hat)
  p_hat = 0;
  q_hat = 0;
  
  prevPhi = 0;
  prevTheta = 0;
  prevPsi = 0;
end


[phi_a theta_a] = EulerAccel(ax, ay); 

[dotPhi dotTheta dotPsi] = KoerperfestZuInertial(p, q, r, prevPhi, prevTheta);

phi   = prevPhi   + dt*(dotPhi   - p_hat);
theta = prevTheta + dt*(dotTheta - q_hat);
psi   = prevPsi   + dt*dotPsi;

p_hat = BerechnePIPhi(phi - phi_a);
q_hat = BerechnePITheta(theta - theta_a);

prevPhi   = phi;
prevTheta = theta;
prevPsi   = psi;


function [dotPhi dotTheta dotPsi] = KoerperfestZuInertial(p, q, r, phi, theta)
% Bod rate --> Euler angular rate
%
sinPhi   = sin(phi);    cosPhi   = cos(phi);
cosTheta = cos(theta);  tanTheta = tan(theta);

dotPhi   = p + q*sinPhi*tanTheta + r*cosPhi*tanTheta;
dotTheta =     q*cosPhi          - r*sinPhi;
dotPsi   =     q*sinPhi/cosTheta + r*cosPhi/cosTheta;