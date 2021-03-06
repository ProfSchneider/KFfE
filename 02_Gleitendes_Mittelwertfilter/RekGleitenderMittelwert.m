%****************************************************************
% Modul	          : RekGleitenderMittelwert(x)                  *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Berechnet den gleitenden Mittelwert f�r     *
%                   n=10 Werte in rekursiver Form               *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte �nderung : 23. September 2016                          *
%                                                               *
%***************************************************************/
function RGM = RekGleitenderMittelwert(x)
%
%
persistent vorherigerRGM n aSchieberegister
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  n    = 10; % gleitender Mittelwert �ber 10 Werte
  aSchieberegister = x*ones(n+1, 1);
  
  k = 1;
  vorherigerRGM = x;
  
  bErsterDurchlauf = 1;  
end

%% alten Wert l�schen, neuen Wert hinzuf�gen
for m=1:n
  aSchieberegister(m) = aSchieberegister(m+1);
end
aSchieberegister(n+1) = x;

RGM = vorherigerRGM + (x - aSchieberegister(1)) / n;


vorherigerRGM = RGM;