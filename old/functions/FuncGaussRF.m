function [RF X] = FuncGaussRF( esp, sigma, Lc, T, N3D, N1D, Nmod, Nray, rea, FieldName )

%s = RandStream('mt19937ar','Seed', 5489);
%RandStream.setDefaultStream(s);
%s = RandStream('mcg16807', 'Seed',0);
%RandStream.setDefaultStream(s);
rand('state',sum(100*clock))
randn('state',sum(100*clock))

nbr_noeuds3D = N3D; %nbr de noeuds dans la grille 3D
nbr_noeuds1D = N1D; %%% nb de noeuds pour les realisations 1D /!\ IMPAIR
nbr_rayons = Nray; %%% nb de rayons pour bandes tournantes
nbr_modes = Nmod; %nbr de mode retenu pour la décomposition 1D


path1 = ['./' FieldName '/'];
%[~,~] = mkdir([path1 '/realisations']);
nbr_modes_init = nbr_modes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creation de coord.dat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=nbr_noeuds3D;
i=0:(n-1);
i=T*i'/(size(i,2)-1);
X=[repmat(i,n^2,1) repmat(sort(repmat(i,n,1)),n,1) sort(repmat(i,n^2,1))];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PREMIERE PARTIE -- DECOMPOSITION 1D 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=nbr_noeuds1D;
T=T*2; % ! MODIF ICI x2 pour faire des rea 1D sur un segment de longueur 2xT !
le = T/(n-1);
%--------------------------------------------------------> PVP <---------%
%%%%%%%%%%%%%%%%%%%%
%CREATION DE LA MATRICE DE MASSE GLOBALE
single SpMass_Global;
D = sparse(1:n,1:n,2*le/3*ones(1,n),n,n);
E = sparse(2:n,1:n-1,le/6*ones(1,n-1),n,n);
D(1,1)=D(1,1)/2;
D(n,n)=D(n,n)/2;
SpMass_Global = E+D+E';
clear E;
clear D;

%%%%%%%%%%%%%%%%%%%%
%CREATION DE LA MATRICE DE COVARIANCE
single MCOVM;
i=1:n;
d = abs(repmat(i,n,1)-repmat(i',1,n))*le;
MCOVM = sigma^2*exp(-(d.^2)/Lc^2).*(1-2*(d.^2)/Lc^2);
MCOVM = SpMass_Global*MCOVM*SpMass_Global;
%MCOVM(MCOVM<(max(max(MCOVM))/1000)) = 0;

%%%%%%%%%%%%%%%%%%%%
%RESOLUTION DU PROBLEME AUX VALEURS PROPRES
single Vs;
single Ds;
%display([num2str(rea) ' ' num2str(nbr_modes) ' ' num2str(Lc)])
[Vs,Ds]=eigs(MCOVM,SpMass_Global,nbr_modes);
  
single lambda;
lambda = Ds*ones(nbr_modes,1);
%normalisation
%for i=1:nbr_modes
%  Vs(:,i) = Vs(:,i)/sqrt(Vs(:,i).'*SpMass_Global*Vs(:,i));
%end

single ValVec;
ValVec = sortrows(horzcat(lambda, Vs'),-1);
nbr_modes = length(find(ValVec(:,1) > ValVec(1,1)/1000));
ValVec = ValVec(1:nbr_modes,:);
if ( nbr_modes == nbr_modes_init )
  display(['           Warning : Insufficient number of eigvalues for realisation number ' num2str(rea)])
  display(['               r = ' num2str(ValVec(nbr_modes,1)/ValVec(1,1))])
end

%%%
% PLOT VAL PROPRES
%mode = [1:1:nbr_modes];
%mode_init = [1:1:nbr_modes_init];
%h = figure (1);
%clf;
%plot(mode,ValVec(:,1),'r',mode_init,lambda,'b', 'linewidth', 1);
%leg1 = ['Valeurs propres retenues'];
%leg2 = ['Resultat Brut'];
%legend(leg1, leg2, 'location', 'NorthEast');
%grid on;
%xlabel('Mode');
%ylabel('Valeur Propre');
%title('Spectre');
%q1 = ['vap.eps'];
%saveas(h,q1, 'psc2')
  
clear lambda;
clear SpMass_Global;
clear MCOVM;
clear Vs;
clear Ds;
  
%--------------------------------------------------------> ENR <---------%
q1 = [path1 'parametres' num2str(rea) '.txt'];
fid1 = fopen(q1,'w');
fprintf(fid1, 'Champ Gaussien\n Donnees Generation\n Nombre de noeuds 3D = %g\n Nombre de noeuds 1D = %g\n Nomre rayons = %g\n Nombre de modes = %g \n Nombre de modes retenus = %g\n\n T = %g\n sigma = %g\n Lc = %g', nbr_noeuds3D, nbr_noeuds1D, nbr_rayons, nbr_modes_init, nbr_modes, T/2.0, sigma, Lc);
fclose(fid1);
q2 = [path1 '/vap' num2str(rea) '.txt'];
fid2 = fopen(q2,'w');
fprintf(fid2,'%g\n',ValVec(:,1).');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEUXIEME PARTIE -- RECOMPOSITIONS 1D et 3D 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=T/2; %Retour taille normale pour 3D
       %------------------------------------------------------------------------%
       %-----------------------------------> START <------------> RF <----------%
       %Generation des rayons 1D%------------------------------------%
       %------------------------------------------------------------------------%
rayon = zeros(nbr_rayons,3,'single');
u1=2*rand(nbr_rayons,1)-1;
u2=2*rand(nbr_rayons,1)-1;
u3=2*rand(nbr_rayons,1)-1;
rayon(:,1) = u1./sqrt(u1.^2 + u2.^2 + u3.^2);
rayon(:,2) = u2./sqrt(u1.^2 + u2.^2 + u3.^2);
rayon(:,3) = u3./sqrt(u1.^2 + u2.^2 + u3.^2);
%rayon(:,1) = cos(2*pi*u1).*sqrt(1-u2.^2);
%rayon(:,2) = sin(2*pi*u1).*sqrt(1-u2.^2);
%rayon(:,3) = u2;

%------------------------------------------------------------------------%
%-----------------------------------> START <------------> RF <----------%
%matrice de toutes les realisations 1D%------------------------------------%
%------------------------------------------------------------------------%
    %--------------------------------------------------------> RF 1D <-------%
  n=nbr_noeuds1D;
  Xi=randn(nbr_modes,nbr_rayons);
  Gamma=zeros(n,nbr_rayons);
  for i=1:n
    for j=1:nbr_rayons
     Gamma(i,j) = sum(sqrt(ValVec(:,1)).*ValVec(:,i+1).*Xi(:,j));
    end
  end

  %--------------------------------------------------------> RF 3D <-------%
  % Modif JBC pour bandes tournantes
  n=nbr_noeuds3D;
  RF = zeros(n^3,1,'single');

  for l=1:nbr_rayons
  	alpha = (X(:,1)-T/2)*rayon(l,1)+(X(:,2)-T/2)*rayon(l,2)+(X(:,3)-T/2)*rayon(l,3);
    %Origine de la sphere au centre du cube
    RF(:,1) = RF(:,1) + Gamma(round(alpha/(2*T)*nbr_noeuds1D)+ceil(nbr_noeuds1D/2),l)/sqrt(nbr_rayons);
  end

  RF = RF+esp;
