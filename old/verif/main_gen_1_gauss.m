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
N1D = 501; %%% nb de noeuds pour les realisations 1D /!\ IMPAIR
Nray = 501; %%% nb de rayons pour bandes tournantes

Lc =10;
Nmod = 50;
T=100;
sigma=5;
esp=0;

folder = ['Gauss_N3D_' num2str(N3D) '_s' num2str(sigma) '_T' num2str(T) '_Lc' num2str(Lc)];

matlabpool(4)
parfor id=1:4
    FieldName = [folder '__' num2str(id)];
    [~,~] = mkdir(FieldName);
    [Gamma_3D X] = FuncGaussRF( esp, sigma, Lc, T, N3D, N1D, Nmod, Nray, id, FieldName );
    test_plot = [0 1 0]; % [VTK TXT DAT] | [paraview verif_adler genmorpho]
    FuncPlotRF( X, Gamma_3D, N3D, T, test_plot, ['run_verif/' FieldName] );
    [~,~] = rmdir(FieldName);
end
matlabpool close

%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('-------------') %-----------------------------------------------%
display('-->  END  <--') %-----------------------------------------------%
display('-------------') %-----------------------------------------------%
%exit; %------------------------------------------------------------------%
%------------------------------------------------------------------------%
