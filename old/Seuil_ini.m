function [u_0 ELKCu] = Seuil_ini(fvi,Lc,T,u_th)

u_0 = zeros(1,3);

%% Pour le champ aléatoire avec la "grande" longueur de corrélation

ELKC1 = FuncThLKC_3D(T,1,0,Lc(1),u_th,1);

[c,I1] = min(abs(ELKC1(1,:)-0.25*fvi));
u_0(1) = u_th(I1);



if ELKC1(4,I1)<0
    display('-------------------------------------------');
    display('-------------------------------------------');
    display('-- /!\ Caractéristique d''Euler négative --');
    display('-------------------------------------------');
    display('-------------------------------------------');

end 

h = figure (1);
clf;

subplot(3,2,1);
plot(u_th,ELKC1(1,:),'linewidth', 1);
grid on;
hold on;
xlabel('Tresholds u');
ylabel('Volume');
text(u_th(I1),-0.05, num2str(u_th(I1)),'HorizontalAlignment','center')
plot([u_th(I1) u_th(I1)],[0 1],'r-.','linewidth',1.5) 
title(['Lc1=' num2str(Lc(1))])

subplot(3,2,2);
plot(u_th,ELKC1(4,:),'linewidth', 1);
hold on;
plot([u_th(I1) u_th(I1)],[-10 max(ELKC1(4,:))],'g-.','linewidth',1.5) 
grid on;
xlabel('Tresholds u');
ylabel('Euler Characteristic');

%% Pour le champ aléatoire avec la "moyenne" longueur de corrélation

ELKC2 = FuncThLKC_3D(T,1,0,Lc(2),u_th,1);

[c,I2] = min(abs(ELKC2(1,:)-((0.5*fvi)/(1-0.25*fvi))));
u_0(2) = u_th(I2);

if ELKC2(4,I2)<0
    display('-------------------------------------------');
    display('-------------------------------------------');
    display('-- /!\ Caractéristique d''Euler négative --');
    display('-------------------------------------------');
    display('-------------------------------------------');
end 


subplot(3,2,3);
plot(u_th,ELKC2(1,:),'linewidth', 1);
grid on;
hold on;
xlabel('Tresholds u');
ylabel('Volume');
text(u_th(I2),-0.05,num2str(u_th(I2)),'HorizontalAlignment','center')
plot([u_th(I2) u_th(I2)],[0 1],'r-.','linewidth',1.5) 
title(['Lc2=' num2str(Lc(2))])

subplot(3,2,4);
plot(u_th,ELKC2(4,:),'linewidth', 1);
grid on;
hold on;
plot([u_th(I2) u_th(I2)],[-10 max(ELKC2(4,:))],'g-.','linewidth',1.5) 
xlabel('Tresholds u');
ylabel('Euler Characteristic');


%% Pour le champ aléatoire avec la "petite" longueur de corrélation
 ELKC3 = FuncThLKC_3D(T,1,0,Lc(3),u_th,1);

[c,I3] = min(abs(ELKC3(1,:)-((0.25*fvi)/(1-0.25*fvi-((0.5*fvi)/(1-0.25*fvi)) + 0.25*fvi*((0.5*fvi)/(1-0.25*fvi))))));
u_0(3) = u_th(I3);

if ELKC3(4,I3)<0
    display('-------------------------------------------');
    display('-------------------------------------------');
    display('-- /!\ Caractéristique d''Euler négative --');
    display('-------------------------------------------');
    display('-------------------------------------------');
end 

subplot(3,2,5);
plot(u_th,ELKC3(1,:),'linewidth', 1);
grid on;
hold on;
xlabel('Tresholds u');
ylabel('Volume');
text(u_th(I3),-0.05,num2str(u_th(I3)),'HorizontalAlignment','center')
plot([u_th(I3) u_th(I3)],[0 1],'r-.','linewidth',1.5) 
title(['Lc3=' num2str(Lc(3))])

subplot(3,2,6);
plot(u_th,ELKC3(4,:),'linewidth', 1);
grid on;
hold on;
plot([u_th(I3) u_th(I3)],[-10 max(ELKC3(4,:))],'g-.','linewidth',1.5) 
xlabel('Tresholds u');
ylabel('Euler Characteristic');

%%
ELKCu=zeros(4,1);

for a=1:1:4
    ELKCu(a) = ELKC1(a,I1) + ELKC2(a,I2)*( 1 - ELKC1(1,I1) ) + ELKC3(a,I3)*( 1 - ( ELKC1(1,I1) + ELKC2(1,I2) - ELKC1(1,I1)*ELKC2(1,I2) ) );
end

