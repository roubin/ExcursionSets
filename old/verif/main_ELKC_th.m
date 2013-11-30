clear;
path(path,'../functions');

display('| START |')

%parametres
sigma=1;
Lc=10;
T=100;
esp = 0.0;

umin=0.0;
umax=5;
uint_th=0.1;

u_th = [umin:uint_th:umax];

%chi_ddl=size(Lc,2); % k=0; : champ Gaussien; k=k, k>0 : champ khi2 a k degrees de liberte
chi_ddl=1;

titre=['Lc ='];
for i=1:chi_ddl
  titre = [titre ' ' num2str(Lc(i))];
end


disp('th ...')
%th values
ELKC_th=FuncThLKC_3D(T,sigma,esp,Lc,u_th,chi_ddl);

%dat
DAT = horzcat(u_th',ELKC_th');
name = 'RF_Carac_th.dat';
fid = fopen(name, 'w');
fseek(fid,0, -1);
fprintf(fid,'#Theroricals values\n');
fprintf(fid,'#U\t\tVolume\t\tSurface\t\tCaliper D\tEuler Carac\n');
fprintf(fid,'%e\t%e\t%e\t%e\t%e\n', DAT');
fclose(fid);
disp('done.')

figure(1)
plot(u_th,ELKC_th(1,:))
figure(2)
plot(u_th,ELKC_th(4,:))
display('| END |')
