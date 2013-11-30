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
N1D = 41; %%% nb de noeuds pour les realisations 1D /!\ IMPAIR
Nray = 51; %%% nb de rayons pour bandes tournantes


T=100;
Lcs    = [015 010 007 005];
Nmods  = [020 020 020 020];
sigmas = [001 001 001 001];
esps   = [000 000 000 000];

Nrea = size(Lcs,2);

folder = ['Khi2_1_N3D_union']
test_plot = [1 1 0]; % [VTK TXT DAT] | [paraview verif_adler genmorpho]

H = zeros(N3D.^3,1);

keep_rea = false;

matlabpool(min(8,Nrea))
parfor rea=1:Nrea
  Lc    = Lcs(rea);
  Nmod  = Nmods(rea);
  esp   = esps(rea);
  sigma = sigmas(rea);
  display(['---> RF number ' num2str(rea) ' Lc = ' num2str(Lc) ' <---'])
  [Gamma_3D X] = FuncGaussRF( esp, sigma, Lc, T, N3D, N1D, Nmod, Nray, rea, folder );

  if(keep_rea)
    FieldName = [folder '/rea_number_' num2str(rea)];
    FuncPlotRF( X, Gamma_3D.^2, N3D, T, test_plot, FieldName );
  end
    
  H = max(H,Gamma_3D.^2);  
end

matlabpool close

% UNION -> champ aleatoire
display('---> Maximum <---')
FieldName = [folder '/Maximum_' folder];
i=0:(N3D-1);
i=T*i'/(size(i,2)-1);
X=[repmat(i,N3D^2,1) repmat(sort(repmat(i,N3D,1)),N3D,1) sort(repmat(i,N3D^2,1))];
FuncPlotRF( X, H, N3D, T, test_plot, FieldName )



%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('-------------') %-----------------------------------------------%
display('-->  END  <--') %-----------------------------------------------%
display('-------------') %-----------------------------------------------%
%exit; %------------------------------------------------------------------%
%------------------------------------------------------------------------%
