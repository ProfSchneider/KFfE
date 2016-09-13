%****************************************************************
% Modul	          : LeseSpannung                                *
%                                                               *
% Datum           : 13. September 2016                          *
%                                                               *
% Funktion        : Zufällige Spannungswerte werden simuliert   *
%                                                               *
% Implementation  : MATLAB R2016a                               *
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
function z = LeseSpannung()
%
%% Mittelwertfreies Rauschen mit einer Standardabweichung von 4V
w = 0 + 4*randn(1,1); % Rauschen
z = 14.4 + w; % Mittelwert + Rauschen