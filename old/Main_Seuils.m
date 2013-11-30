% MAIN
clear all;
close all;
path(path, './functions/')
%tic 
display('---------');
display('| START |');
display('---------');

 
T   = 100;      % Taille du cube dans lequel on va générer des microstructures
fvi = 0.38;     % Rapport massique eau sur ciment pour le mortier

% A partir d'une courbe granulométrique, on place
% uniquement 3 points, à 75, 50 et 25% de tamisat
Lc = [15 7 2];%valeurs réels des tamis en micrometres correspondant à un CEM V de Lafarge

display('-> Détermination des seuils initiaux <-');
% Determination des seuils initiaux pour la morphologie initiale
umin=0; 
umax=10;
uint=0.25;
u_th = umin:uint:umax;
[u_0 ELKCu] =  Seuil_ini(fvi,Lc,T,u_th);
% close all
% 
% 
% display('--> Start Union & Intersections <--');
% % Génération des 3 champs, et union.
% N3D = 200;  % nbr de noeuds dans la grille 3D
% N1D = 2000;  % nb de noeuds pour les realisations 1D /!\ IMPAIRE (BANDES TOURNANTES)
% Nray = 2001; % nb de rayons pour bandes tournantes
% 
% Nmods  = [50 100 300]; % Valeurs < N1D-2
% sigmas = [1 1 1];
% esps   = [0 0 0];
% keep_rea = true;
% test_plot = [1 1 0]; % [VTK TXT DAT] | [paraview verif_adler genmorpho]
% 
% Uname = generation_3RF_union(N3D,N1D,Nray,Lc,Nmods,sigmas,esps,T,keep_rea,u_0,test_plot);
% 
% display('--> Verification Experimentale <--');
% [ELKC_exp, T] = FuncExpLKC_3D(Uname, 0);

% display(['Fraction Volumique experimentale : ' num2str(ELKC_exp(1,1))]);
% display(['Fraction Volumique theorique     : ' num2str(ELKCu(1,1))]);
% display(['Carac d euler experimentale      : ' num2str(ELKC_exp(4,1))]);
% display(['Carac d euler theorique          : ' num2str(ELKCu(4,1))]);
% 
% 
% 
% 
% 
% display('---------');
% display('|  END  |');
% display('---------');
