clear %------------------------------------------------------------------%
path(path,'../functions');
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('-------------') %-----------------------------------------------%
display('--> START <--') %-----------------------------------------------%
display('-------------') %-----------------------------------------------%
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%

N3D = 100; %nbr de noeuds dans la grille 3D
N1D = 5001; %%% nb de noeuds pour les realisations 1D /!\ IMPAIR
Nray = 5001; %%% nb de rayons pour bandes tournantes

Nmod = 300;
T=100;

sigma=1;
esp=2.0;
Lc =15;

folder = ['Chi2_1_N3D_' num2str(N3D) '_s' num2str(sigma) '_T' num2str(T) '_Lc' num2str(Lc)];

id = 1;
FieldName = [folder '__' num2str(id)]
[Gamma_3D X] = FuncGaussRF( esp, sigma, Lc, T, N3D, N1D, Nmod, Nray, id, FieldName );
test_plot = [1 1 0]; % [VTK TXT DAT] | [paraview verif_adler genmorpho]
FuncPlotRF( X, Gamma_3D.^2, N3D, T, test_plot, FieldName );


%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('-------------') %-----------------------------------------------%
display('-->  END  <--') %-----------------------------------------------%
display('-------------') %-----------------------------------------------%
%exit; %------------------------------------------------------------------%
%------------------------------------------------------------------------%
