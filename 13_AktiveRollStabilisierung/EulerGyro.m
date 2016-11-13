%****************************************************************
% Modul			  : EulerGyro.m                                 *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Integration der Drehraten in Eulerwinkel    *
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

function [phi theta psi] = EulerGyro(p, q, r, dt)
%
%
persistent prevPhi prevTheta prevPsi

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(prevPhi)
  prevPhi   = 0;
  prevTheta = 0;
  prevPsi   = 0;
end

%% Umrechnung der Messwerte der Gyroskope in die Drehraten der Eulerwinkel
sinPhi   = sin(prevPhi);    cosPhi   = cos(prevPhi);
cosTheta = cos(prevTheta);  tanTheta = tan(prevTheta);

%% Integration der Winkelgeschwindigkeiten zu Eulerwinkeln
phi   = prevPhi   + dt*( p + q*sinPhi*tanTheta + r*cosPhi*tanTheta );
theta = prevTheta + dt*(     q*cosPhi          - r*sinPhi );
psi   = prevPsi   + dt*(     q*sinPhi/cosTheta + r*cosPhi/cosTheta );

%% Rückgabewerte (Eulerwinkel) speichern
prevPhi   = phi;
prevTheta = theta;
prevPsi   = psi; 