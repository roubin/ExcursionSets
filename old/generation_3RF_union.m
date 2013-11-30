function Uname = generation_3RF_union(N3D,N1D,Nray,Lc,Nmods,sigmas,esps,T,keep_rea,u_0,test_plot)
%génération de 3 champs aléatoires
%------------------------------------------------------------------%
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('--> START RF YIELDING<--') %------------------------------------%
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%

Nrea = size(Lc,2);

folder_trial = ['Khi2_1_N3D_' num2str(N3D) '_union_Lcs_' num2str(Lc(1)) '_' num2str(Lc(2)) '_' num2str(Lc(3))];
id=0;
folder = [folder_trial '_id' num2str(id)];
while(exist(folder,'dir')==7)
    id = id+1;
    folder = [folder_trial '_id' num2str(id)];
end
[~,~] = mkdir(folder);
display(folder)


Gamma_3D = zeros(Nrea,N3D.^3);

matlabpool(min(8,Nrea))
parfor rea=1:Nrea
  Nmod  = Nmods(rea);
  esp   = esps(rea);
  sigma = sigmas(rea);
  display(['---> RF number ' num2str(rea) ' Lc = ' num2str(Lc(rea)) ' <---'])
  [Gamma_3D(rea,:) X] = FuncGaussRF( esp, sigma, Lc(rea), T, N3D, N1D, Nmod, Nray, rea, folder );
  if(keep_rea)
    FieldName = [folder '/rea_number_' num2str(rea)];
    FuncPlotRF( X, Gamma_3D(rea,:).^2, N3D, T, test_plot, FieldName );
  end      
end
matlabpool close

display('---> Maximum <---')
H = Gamma_3D(1,:).^2-u_0(1);
for rea=2:Nrea
    H = max(H,Gamma_3D(rea,:).^2-u_0(rea));
end
Uname = [folder '/Maximum_' folder];
i=0:(N3D-1);
i=T*i'/(size(i,2)-1);
X=[repmat(i,N3D^2,1) repmat(sort(repmat(i,N3D,1)),N3D,1) sort(repmat(i,N3D^2,1))];
FuncPlotRF( X, H, N3D, T, test_plot, Uname )

%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
display('-->  END  RF YIELDING <--') %-----------------------------------%
%exit; %------------------------------------------------------------------%
%------------------------------------------------------------------------%
