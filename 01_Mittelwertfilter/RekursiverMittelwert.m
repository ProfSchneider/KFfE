%****************************************************************
% Modul	          : RekursiverMittelwert(x)                     *
%                                                               *
% Datum           : 13. September 2016                          *
%                                                               *
% Funktion        : Berechnung eines rekursiven Mittelwertes    *
%                                                               *
% Implementation  : MATLAB R2013a                               *
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


function Mittelwert = RekursiverMittelwert(x)
%
%
persistent fVorherigerMittelwert k 
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ertsen Durchlauf
if isempty(bErsterDurchlauf)
  k = 1;
  fVorherigerMittelwert = 0;
  
  bErsterDurchlauf = 1;  
end


alpha = (k - 1) / k;
Mittelwert   = alpha*fVorherigerMittelwert + (1 - alpha)*x;

fVorherigerMittelwert = Mittelwert;
k       = k + 1;