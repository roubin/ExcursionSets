%clear;
display('| START |')

%parametres
sigma=1;
Lc=15;
T=100;

umin=-5;
umax=5;
uint_th=0.01;
uint_exp=0.1;


exp=0;
th=1;

fold1 = 'run_verif';

%chi_ddl=size(Lc,2); % k=0; : champ Gaussien; k=k, k>0 : champ khi2 a k degrees de liberte
chi_ddl=0;

titre=['Lc ='];
for i=1:chi_ddl
  titre = [titre ' ' num2str(Lc(i))];
end


if(exp==1)
  %exp values
  disp('exp ...')
  [u_exp, ELKC_exp, T] = FuncExpLKC_3D( [fold1 '/'], umin, umax, uint_exp);
  %plot frac vol
  %h = figure (1); clf;
  %plot(u_exp,ELKC_exp(1,:),'+','linewidth', 1);
  %grid on;
  %xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
  %ylabel('$$Volume Fraction$$','FontSize',14,'Interpreter','latex')
  %q1 = ['Vol_Exp.eps'];
  %saveas(h,q1, 'psc2');
  
  %plot euler carac
  %h = figure (2); clf;
  %plot(u_exp,ELKC_exp(4,:),'+','linewidth', 1);
  %grid on;
  %xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
  %ylabel('$$Euler Caracteritic$$','FontSize',14,'Interpreter','latex')
  %q1 = ['EC_Exp.eps'];
  %saveas(h,q1, 'psc2');

  %dat
  DAT = horzcat(u_exp',ELKC_exp');
  name = 'RF_Carac_exp.dat';
  fid = fopen(name, 'w');
  fseek(fid,0, -1);
  fprintf(fid,'#Experimental values\n');
  fprintf(fid,'#U\t\tVolume\t\tSurface\t\tCaliper D\tEuler Carac\n');
  fprintf(fid,'%e\t%e\t%e\t%e\t%e\n', DAT');
  fclose(fid);
  disp('done.')
end


if(th==1)
  disp('th ...')
  %th values
  [u_th, ELKC_th]=FuncThLKC_3D(T,sigma,Lc,umin,umax,uint_th,chi_ddl);
  
  %N  = size(Lc,2);
  %N_u = size((umin:uint_th:umax),2);  
  %L3 = zeros(N, N_u);
  %L1 = zeros(N, N_u);
  %for i = 1:size(Lc,2)
  %    [u_th, ELKC_th] = FuncThLKC_3D(T,sigma,Lc(1,i),umin,umax,uint_th,1);
  %    L3(i,:) = ELKC_th(1,:);
  %    L1(i,:) = ELKC_th(4,:);    
  %end  
  %for i=1:N_u
  %    [ELKC_th(4,i) ELKC_th(1,i)] = get_union(L1(:,i), L3(:,i));
  %end  
  %[u_th, ELKC_th_patate] = FuncAPPROXLKC_3Lc_3D(T,sigma,Lc(1,1),Lc(1,2),Lc(1,3),umin,umax,uint_th,1);

  
  %plot frac vol
  %h = figure (3); clf;
  %plot(u_th,ELKC_th(1,:));  
  %grid on;
  %xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
  %ylabel('$$Volume Fraction$$','FontSize',14,'Interpreter','latex')
  %q1 = ['Vol_Th.eps'];
  %saveas(h,q1, 'psc2')

  %plot euler carac
  %h = figure (4); clf;
  %plot(u_th,ELKC_th(4,:));
  %grid on;
  %xlabel('Tresholds u','FontSize',14,'Interpreter','latex')
  %ylabel('Euler Caracteritic','FontSize',14,'Interpreter','latex')
  %q1 = ['EC_Th.eps'];
  %saveas(h,q1, 'psc2')

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
end



%if(th+exp==2)
  %plot frac vol
  h = figure (5); clf;
  plot(u_th,ELKC_th(1,:),u_exp,ELKC_exp(1,:),'+','linewidth', 1);
  grid on;
  xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
  ylabel('$$Volume Fraction$$','FontSize',14,'Interpreter','latex')
  q1 = 'Vol_Th_VS_Exp.eps';
  saveas(h,q1, 'psc2')
  
  %plot euler carac
  h = figure (6); clf;
  plot(u_th,ELKC_th(4,:),u_exp,ELKC_exp(4,:),'+','linewidth', 1);
  grid on;
  xlabel('$$Tresholds \, u$$','FontSize',14,'Interpreter','latex')
  ylabel('$$Euler Caracteritic$$','FontSize',14,'Interpreter','latex')
  q1 = 'EC_Th_VS_Exp.eps';
  saveas(h,q1, 'psc2')
%end


display('| END |')
%exit;
