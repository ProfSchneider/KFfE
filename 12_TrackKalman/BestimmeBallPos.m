%****************************************************************
% Modul			  : BestimmeBallPos.m                           *
%				                            					*
% Datum           : 18-Nov-2013                                 *
%                                                               *
% Funktion        : Bildverarbeitung liefert Position eines     *
%                   Balls                                       *
%                                                               *
% Implementation  : MATLAB 2016a                  			    *
%                                                               *
% Author          : (c) 2011 Phil Kim, Alle Rechte vorbehalten. *
%                   Bearbeitet von Prof. Schneider              *
%                                                               *
% Original        : https://github.com/philbooks/               *
% Quelle          : https://github.com/ProfSchneider/KFfE/      *
%                                                               *
% Letzte ƒnderung : 13. November 2016                           *
%                                                               *
%***************************************************************/

function [xc, yc] = BestimmeBallPos(index)
%
%
persistent aHintergrundBild
persistent bErsterDurchlauf

%% Initalisierung der Variablen bei ersten Durchlauf
if isempty(bErsterDurchlauf)
  aHintergrundBild = imread('Img/bg.jpg'); % Hintergrundbild laden
  
  bErsterDurchlauf = 1;
end

xc = 0;
yc = 0;
  
aAktuellesBild = imread(['Img/', int2str(index), '.jpg']); 
imshow(aAktuellesBild)

aVordergrundBild = imabsdiff(aAktuellesBild, aHintergrundBild); % Ball ohne Hintergrund

%% Schwellwertbehandlung
aVordergrundBild = (aVordergrundBild(:,:,1) > 10) |...
                   (aVordergrundBild(:,:,2) > 10) | ...
                   (aVordergrundBild(:,:,3) > 10);

L = logical(aVordergrundBild); % Bin‰rbild erzeugen - weiﬂer Ball auf schwarzem Grund

%% Region Labeling
stats = regionprops(L, 'area', 'centroid');
area_vector = [stats.Area];
[tmp, idx] = max(area_vector);

centroid = stats(idx(1)).Centroid;

%% Positionsrauschen addieren
xc = centroid(1) + 15*randn;
yc = centroid(2) + 15*randn;
  