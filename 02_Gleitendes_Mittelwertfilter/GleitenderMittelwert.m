%****************************************************************
% Modul	          : GleitenderMittelwert(x)                     *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Berechnet den gleitenden Mittelwert für     *
%                   n=10 Werte                                  *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 13. September 2016                          *
%                                                               *
%***************************************************************/

function GM = GleitenderMittelwert(x)
%
%
persistent n aSchieberegister
persistent bErsterDurchlauf

%% Initialisierung des Array
if isempty(bErsterDurchlauf) 
  n = 10;
  aSchieberegister = x*ones(n, 1);
  
  bErsterDurchlauf = 1;  
end

%% alten Wert löschen, neuen Wert hinzufügen
for m=1:n-1
  aSchieberegister(m) = aSchieberegister(m+1);
end
aSchieberegister(n) = x;

GM = sum(aSchieberegister) / n;


