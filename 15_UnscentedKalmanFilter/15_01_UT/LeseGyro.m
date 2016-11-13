%****************************************************************
% Modul			  : LeseGyro.m                                 *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Gibt den aktuellen Beschleunigungsmesswert  *
%                   aus der Messwertdatei ArsAccel.mat zurück.  *
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

function [p q r] = LeseGyro()
%
%
persistent wx wy wz
persistent k bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf) 
  load ArsGyro % lade ArsGyro.mat
  k = 1;
  
  bErsterDurchlauf = 1;
end

%% Rückgabewerte
p = wx(k);
q = wy(k);
r = wz(k);
  
k = k + 1;
