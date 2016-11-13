%****************************************************************
% Modul			  : EulerInQuaternionen.m                       *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Umrechnung der Eulerwinkel in Quaternionen  *
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

function z = EulerInQuaternionen(phi, theta, psi)
%
%
sinPhi   = sin(phi/2);    cosPhi   = cos(phi/2);
sinTheta = sin(theta/2);  cosTheta = cos(theta/2);
sinPsi   = sin(psi/2);    cosPsi   = cos(psi/2);

z = [ cosPhi*cosTheta*cosPsi + sinPhi*sinTheta*sinPsi;
      sinPhi*cosTheta*cosPsi - cosPhi*sinTheta*sinPsi;
      cosPhi*sinTheta*cosPsi + sinPhi*cosTheta*sinPsi;
      cosPhi*cosTheta*sinPsi - sinPhi*sinTheta*cosPsi;
    ];