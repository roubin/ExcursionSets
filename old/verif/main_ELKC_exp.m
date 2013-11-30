clear;
path(path,'../functions');

display('| START |')

%parametres
%sigma=5;
%Lc=10;
%T=100;
%esp = 0;

%umin=-25;
%umax=25;

%uint_th=1;
%uint_ex=1;

%u_th = umin:uint_th:umax;
%u_ex = umin:uint_ex:umax;
u_ex = 0

fold1 = 'run_verif'; % dossier ou on met les .txt

%chi_ddl=size(Lc,2); % k=0; : champ Gaussien; k=k, k>0 : champ khi2 a k degrees de liberte
%chi_ddl=0;


%ELKC_th=FuncThLKC_3D(T,sigma,esp,Lc,u_th,chi_ddl);
[ELKC_exp, varELKC_exp] = FuncExpLKC_3D_2( [fold1 '/'], u_ex);

%h = figure (5); clf;
%plot(u_th,ELKC_th(1,:),u_ex,ELKC_exp(1,:),'+','linewidth', 1);
%grid on;
%xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
%ylabel('$$Volume Fraction$$','FontSize',14,'Interpreter','latex')
%q1 = 'Vol_Th_VS_Exp.eps';
%saveas(h,q1, 'psc2')
  
%plot euler carac
%h = figure (6); clf;
%plot(u_th,ELKC_th(4,:),u_ex,ELKC_exp(4,:),'+','linewidth', 1);
%grid on;
%xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
%ylabel('$$Euler Caracteritic$$','FontSize',14,'Interpreter','latex')
%q1 = 'EC_Th_VS_Exp.eps';
%saveas(h,q1, 'psc2')
  
%err_L0 = sum(abs((ELKC_th(4,:)-ELKC_exp(4,:))/ELKC_th(4,:)))/51*100;
%err_L3 = sum(abs((ELKC_th(1,:)-ELKC_exp(1,:))/ELKC_th(1,:)))/51*100;



%dat
%DAT = horzcat(u_th',ELKC_th');
%name = 'RF_Carac_th.dat';
%fid = fopen(name, 'w');
%fseek(fid,0, -1);
%fprintf(fid,'#Theroricals values\n');
%fprintf(fid,'#U\t\tVolume\t\tSurface\t\tCaliper D\tEuler Carac\n');
%fprintf(fid,'%e\t%e\t%e\t%e\t%e\n', DAT');
%fclose(fid);

%dat
%DAT = horzcat(u_ex',ELKC_exp');
%name = 'RF_Carac_exp.dat';
%fid = fopen(name, 'w');
%fseek(fid,0, -1);
%fprintf(fid,'#Experimental values\n');
%fprintf(fid,'#U\t\tVolume\t\tSurface\t\tCaliper D\tEuler Carac\n');
%fprintf(fid,'%e\t%e\t%e\t%e\t%e\n', DAT');
%fclose(fid);






display('| END |')
