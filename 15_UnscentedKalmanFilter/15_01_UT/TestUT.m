%****************************************************************
% Modul			  : TestEulerKalman.m                           *
%				                            					*
% Datum           : 02-Dez-2013                                 *
%                                                               *
% Funktion        : Startfunktion für die unscented             *
%                   Transformation                              *
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
xm    = 5;
Px    = 9;
kappa = 2;

[Xi W]      = SigmaPunkte(xm, Px, kappa);
[xAvg xCov] = UT(Xi, W)