%****************************************************************
% Modul			  : SigmaPunkte.m                               *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Berechnung der Sigma-Punkte                 *
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

function [Xi W] = SigmaPunkte(xm, P, kappa)
%
%
n  = numel(xm);
Xi = zeros(n, 2*n+1);         % Sigma-Punkte = Spalte von Xi
W  = zeros(n, 1);

Xi(:, 1) = xm;
W(1)     = kappa / (n + kappa);

U = chol((n+kappa)*P);         % U'*U = (n+kappa)*P

for k=1:n
  Xi(:, k+1) = xm + U(k, :)';   % Zeile von U
  W(k+1)     = 1 / (2*(n+kappa));
end

for k=1:n
  Xi(:, n+k+1) = xm - U(k, :)';
  W(n+k+1)      = 1 / (2*(n+kappa));
end