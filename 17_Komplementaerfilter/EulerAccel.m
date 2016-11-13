%****************************************************************
% Modul			  : EulerAccel.m                                *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Umrechnung der inertialen Beschleunigungen  *
%                   in Eulerwinkel                              *
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

function [phi theta] = EulerAccel(ax, ay)
%
%
g = 9.81; % Erdbeschleunigung in m/(s^2)

% Rückgabewerte sind die Eulerwinkel
theta = asin(  ax / g );
phi   = asin( -ay / (g*cos(theta)) );

 