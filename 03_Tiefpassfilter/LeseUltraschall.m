%****************************************************************
% Modul	          : LeseUltraschall(x)                          *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Gibt einen Messwert aus einer Ultraschall-  *
%                   messung zurück.                             *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 23. September 2016                          *
%                                                               *
%***************************************************************/

function h = LeseUltraschall()
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
