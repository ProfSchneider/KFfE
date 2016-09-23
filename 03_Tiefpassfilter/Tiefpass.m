%****************************************************************
%        Hochschule Hamm-Lippstadt                              *
%****************************************************************
% Modul	          : Tiefpass(x)                                 *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Tiefpassfilter 1. Ordnung mit fester        * 
%                   Wichtung                                    *
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
function xTPF = Tiefpass(x)

%% Bleibende Variablen anlegen
persistent vorherigesX alpha
persistent bErsterDurchlauf

%% Beim ersten Durchlauf Initialisierung
if isempty(bErsterDurchlauf)
  vorherigesX = x;     
  alpha = 0.7;  % Wichtung (Parameter)
  
  bErsterDurchlauf = 1;  
end

%% Tiefpassfilter 1. Ordnung
xTPF = alpha*vorherigesX + (1 - alpha)*x;

vorherigesX = xTPF;