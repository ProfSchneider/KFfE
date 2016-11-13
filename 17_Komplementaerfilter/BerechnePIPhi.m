%****************************************************************
% Modul	          : BerechnePIPhi                               *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Beispielskript zur Berechnung der zeit-     *
%                   diskreten Übertragungsfunktion mit c2dm     *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte Änderung : 09. November 2016                           *
%                                                               *
%***************************************************************/

function p_hat = BerechnePIPhi(delPhi)
%
%
persistent prevP prevdelPhi


if isempty(prevP)
  prevP      = 0;
  prevdelPhi = 0;
end

  
p_hat = prevP + 0.1415*delPhi - 0.1414*prevdelPhi;

prevP      = p_hat;
prevdelPhi = delPhi;