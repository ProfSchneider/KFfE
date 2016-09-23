%****************************************************************
% Modul	          : RekGleitenderMittelwert(x)                  *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Berechnet den gleitenden Mittelwert für     *
%                   n=10 Werte in rekursiver Form               *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Bemerkung       : https://github.com/philbooks/               *
%                                                               *
% Letzte Änderung : 23. September 2016                          *
%                                                               *
%***************************************************************/
function RGM = RekGleitenderMittelwert(x)
%
%
persistent vorherigerRGM n aSchieberegister
persistent bErsterDurchlauf

%% Initialisierung des Array
if isempty(bErsterDurchlauf)
  n    = 10; % gleitendes mittelwertfilter über 10 Werte
  aSchieberegister = x*ones(n+1, 1);
  
  k = 1;
  vorherigerRGM = x;
  
  bErsterDurchlauf = 1;  
end

%% alten Wert löschen, neuen Wert hinzufügen
for m=1:n
  aSchieberegister(m) = aSchieberegister(m+1);
end
aSchieberegister(n+1) = x;

RGM = vorherigerRGM + (x - aSchieberegister(1)) / n;


vorherigerRGM = RGM;