%****************************************************************
% Modul	          : BerechnePITheta                             *
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

function q_hat = BerechnePITheta(delTheta)
%
%
persistent prevQ prevdelTheta


if isempty(prevQ)
  prevQ        = 0;
  prevdelTheta = 0;
end

  
q_hat = prevQ + 0.1415*delTheta - 0.1414*prevdelTheta;

prevQ        = q_hat;
prevdelTheta = delTheta;