%****************************************************************
% Modul	          : BerechneDiskreteForm                        *
%                                                               *
% Datum           : 08-Okt-2013                                 *
%                                                               *
% Funktion        : Beispielskript zur Berechnung der zeit-     *
%                   diskreten �bertragungsfunktion mit c2dm     *
%                                                               *
% Implementation  : MATLAB R2016a                               *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte �nderung : 09. November 2016                           *
%                                                               *
%***************************************************************/
dt=0.01;           % Abtastzeit

Ki = 0.1^2;        % Regelparameter Ki
Kp = sqrt(2)*0.1;  % Regelparameter Kp

num = [Kp Ki];     % Z�hler der �bertragungsfunktion
den = [1 0];       % Nenner der �bertragungsfunktion

%% Konvertierung des kontinuierlichen zeitinvarianten Systems in die diskrete Form
[numd dend] = c2dm(num, den, dt, 'tustin')