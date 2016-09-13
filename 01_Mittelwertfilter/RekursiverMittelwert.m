%****************************************************************
% Modul	          : RekursiverMittelwert(x)                     *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Berechnung eines rekursiven Mittelwertes    *
%                                                               *
% Implementation  : MATLAB R2013a                               *
%                                                               *
% Toolbox         :                                             *
%                                                               *
% Author          : Phil Kim                                    *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Bemerkung       : https://github.com/philbooks/               *
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