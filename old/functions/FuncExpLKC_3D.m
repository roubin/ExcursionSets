function [ELKC, MeanT] = FuncExpLKC_3D( path, tresholds ) 
% LECTURE DU DOSSIER
%ListOfFields = dir([path '/verif']);
%FileRejected = 0;
%for i=1:size(ListOfFields)
%  if(ListOfFields(i).name(1) == '.')
%    FileRejected = FileRejected + 1;
%  end
%end
%Nfile = size(ListOfFields,1)-FileRejected;
Nfile = 1;
% CREATION DES SEUILS
Nt=size(tresholds,2);

% CALCUL CARAC EULER ET SURFACE
Volume = zeros(Nfile,Nt);
EulerCarac = zeros(Nfile,Nt);
T = zeros(Nfile,1);
for file=1:Nfile
  %H = dlmread([path ListOfFields(file+FileRejected).name],',',0,0);
  H = dlmread([path '.txt'],',',0,0);
  T(file) = H(1);
  Field = H(2:size(H,1));
  %Field = Field;
  N3D=size(Field,1);
  %N=round(N3D^(1/3));
  for t=1:Nt
    CalcVol = 0;
    Morpho = zeros(N3D,1);
    for i=1:N3D
      if ( Field(i)>=tresholds(t) )
        Morpho(i) = 1;
	CalcVol = CalcVol+1;
      else
        Morpho(i) = 0;
      end
    end
    EulerCarac(file,t) = FuncECPoly_3D( Morpho );
    Volume(file,t) = CalcVol/N3D;
    clear Morpho;
  end
  clear Field;
end

if (Nfile == 1)
  MeanEulerCarac = EulerCarac;
  MeanVolume = Volume;
else
  MeanEulerCarac = mean(EulerCarac);
  MeanVolume = mean(Volume);
end
 
ELKC = zeros(4,Nt);
ELKC(1,:) = MeanVolume;
ELKC(4,:) = MeanEulerCarac;
MeanT = mean(T);
