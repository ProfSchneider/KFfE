%****************************************************************
% Modul	          : LadeUltraschall(x)                          *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Gibt einen Messwert aus einer Ultraschall-  *
%                   messung zurück.                             *
%                                                               *
% Implementation  : MATLAB R2013a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Bemerkung       : https://github.com/philbooks/               *
%                                                               *
% Letzte Änderung : 23. September 2016                          *
%                                                               *
%***************************************************************/

function h = LadeUltraschall()
%
%
persistent Ultraschallmessung       % Ultraschallmessung.mat
persistent k bErsterDurchlauf


if isempty(bErsterDurchlauf)
  load('Ultraschallmessung.mat')
  k = 1;
  
  bErsterDurchlauf = 1;
end

h = Ultraschallmessung(k);
  
k = k + 1;
