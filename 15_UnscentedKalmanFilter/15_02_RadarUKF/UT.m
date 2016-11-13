%****************************************************************
% Modul			  : UT.m                                        *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Unscented Transformation                    *
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

function [xm xcov] = UT(Xi, W, noiseCov) 
%
%
[n, kmax] = size(Xi);

xm = 0;
for k=1:kmax
  xm = xm + W(k)*Xi(:, k);
end

xcov = zeros(n, n);
for k=1:kmax
  xcov = xcov + W(k)*(Xi(:, k) - xm)*(Xi(:, k) - xm)';
end
xcov = xcov + noiseCov;