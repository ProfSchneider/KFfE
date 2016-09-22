%****************************************************************
% Modul			  : TestSimpleKalman.m                          *
%				                            					*
% Datum           : 22. September 2016                          *
%                                                               *
% Funktion        : Startfunktion eines Kalman-Filters          *
%                                                               *
% Implementation  : MATLAB 2016a                  			    *
%                                                               *
% Author          : Phil Kim                                    *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Bemerkung       : https://github.com/philbooks/               *
%                                                               *
% Letzte Änderung : 22. September 2016                          *
%                                                               *
%***************************************************************/

clear all; close all; clc

dt = 0.2;     % Simulationsschritte in s
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 1);
Zsaved = zeros(Nsamples, 1);

for k=1:Nsamples
  z        = LeseSpannung();  % Messwerte lesen
  Spannung = SimpelKalman(z); % Kalman-Filter
  
  Xsaved(k) = Spannung;
  Zsaved(k) = z;
end

figure
plot(t, Xsaved, 'o-')
xlabel('t in s')
hold on
plot(t, Zsaved, 'r:*') 
ylabel('Batteriespannung in V')