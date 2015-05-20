%% Initial
clear all; clc; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='lognormal_3D.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);

% threshold research zone
p.hitting_set.thresholds=f_set_thresholds(-6,4,0.01, 'log10');

%% size effect
lengths=f_set_thresholds(-4,10,0.1,'log10');
failure_stress=zeros(size(lengths));

list_x01=zeros(size(lengths));
list_x02=zeros(size(lengths));
list_x0q=zeros(size(lengths));

imax=size(lengths,1);
i=0;
for l=1:size(lengths,1)
    i=i+1;
    p.geometrical.sizeX=lengths(l,1);
    %p.geometrical.sizeY=0.00001*lengths(l,1);    
    %p.geometrical.sizeZ=0.00001*lengths(l,1);
    p.geometrical.sizeY=10;
    p.geometrical.sizeZ=10;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% DETECT EXTREMA WITH PRECISION OF THE ARRAY (COARSE) %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tabtresh=p.hitting_set.thresholds;
    tabeuler=f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    maxeuler=max(abs(tabeuler));    
    display([num2str(i/imax*100.0) '% (' num2str(p.geometrical.sizeX) ', ' num2str(p.geometrical.sizeY) ', ' num2str(p.geometrical.sizeZ) ')'])
    [maxtab, mintab]=peakdet(tabeuler, 1e-14, tabtresh);
    nmin=size(mintab,1); nmax=size(maxtab,1);
    
    %display(['     nmin, nmax ' num2str(nmin) ', ' num2str(nmax)]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% DETECT EC->1 (QUANTILE) %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    if(nmax==0)
        maxsearch=tabtresh(end);
    else
        maxsearch=maxtab(1,1);
    end    
    quantile=0.5;
    th_elkc_q =@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t))-quantile;
    [x_quantile, y_quantile]=fzero(th_elkc_q,[min(tabtresh) maxsearch]);
    list_x0q(l)=x_quantile;    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% FIND ZEROS WITH BOUNDARIES BASED ON PREVIOUS EXTRAMA DETECTION %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    findzero=0;
    %%% TWO MAXIMAS %%%
    if(nmin==1 && nmax==2)
        x_min_01=mintab(1,1); y_min_01=mintab(1,2);
        x_max_01=maxtab(1,1); y_max_01=maxtab(1,2);
        x_max_02=maxtab(2,1); y_max_02=maxtab(2,2);
        if(y_min_01*y_max_01<0 && y_min_01*y_max_02<0)
            th_elkc =@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
            [x_0_01, y_0_01]=fzero(th_elkc,[x_max_01 x_min_01]);
            [x_0_02, y_0_02]=fzero(th_elkc,[x_min_01 x_max_02]);
            list_x01(l)=x_0_01; list_x02(l)=x_0_02;
            figure(1); semilogx(tabtresh, tabeuler./maxeuler, [tabtresh(1) tabtresh(end)], [0 0], '--k', [x_min_01 x_min_01], [0 y_min_01/maxeuler], '*--b', [x_max_01 x_max_01], [0 y_max_01/maxeuler], '*--b', [x_max_02 x_max_02], [0 y_max_02/maxeuler], '*--b', [x_0_01 x_0_01], [0 y_0_01/maxeuler], '*--r', [x_0_02 x_0_02], [0 y_0_02/maxeuler], '*-g', [x_quantile x_quantile], [0 quantile./maxeuler], '*--k');
            findzero=1;
        end
        %%% ONE MAXIMAS %%%
    elseif(nmin==1 && nmax==1)
        x_min_01=mintab(1,1); y_min_01=mintab(1,2);
        x_max_01=maxtab(1,1); y_max_01=maxtab(1,2);
        if(y_min_01*y_max_01<0)
            th_elkc =@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
            [x_0_01, y_0_01]=fzero(th_elkc,[x_max_01 x_min_01]);
            [x_0_02, y_0_02]=fzero(th_elkc,[x_min_01 tabtresh(end)]);
            list_x01(l)=x_0_01;
            list_x02(l)=x_0_02;
            figure(1); semilogx(tabtresh, tabeuler./maxeuler, [tabtresh(1) tabtresh(end)], [0 0], '--k', [x_min_01 x_min_01], [0 y_min_01/maxeuler], '*--b', [x_max_01 x_max_01], [0 y_max_01/maxeuler], '*--b', [x_0_01 x_0_01], [0 y_0_01/maxeuler], '*--r', [x_0_02 x_0_02], [0 y_0_02/maxeuler], '*-g', [x_quantile x_quantile], [0 quantile./maxeuler], '*--k');
            %figure(1); semilogx(tabtresh, tabeuler./maxeuler, [tabtresh(1) tabtresh(end)], [0 0], '--k', [x_min_01 x_min_01], [0 y_min_01/maxeuler], '*--b', [x_max_01 x_max_01], [0 y_max_01/maxeuler], '*--b', [x_0_01 x_0_01], [0 y_0_01/maxeuler], '*--r', [x_quantile x_quantile], [0 quantile./maxeuler], '*--k');
            findzero=1;
        end
    end
    
    %%% NO ZEROS FOUND %%%
    if(~findzero)
        figure(1);        
        semilogx(tabtresh, tabeuler./maxeuler, [tabtresh(1) tabtresh(end)], [0 0], '--k', [x_quantile x_quantile], [0 quantile./maxeuler], '*--k');        
    end
    %title(['Size X, Y, Z ' num2str(p.geometrical.sizeX) ', ' num2str(p.geometrical.sizeY) ', ' num2str(p.geometrical.sizeZ)]);
    %xlabel('Threshold')
    %ylabel('Euler')
    %nametmp=sprintf('euler_length_%05d',l);    
    %print(nametmp,'-djpeg')    
end
%%
figure(2); loglog(lengths, list_x01, 'r-*', lengths, list_x02, 'g-*',  lengths, list_x0q, 'k-*')
title(['Size X, Y, Z ' num2str(p.geometrical.sizeX) ', ' num2str(p.geometrical.sizeY) ', ' num2str(p.geometrical.sizeZ)]);
xlabel('length')
ylabel('Threshold')
legend('First 0', 'Second 0', 'First EC=0.5','Location','southwest')
print('size_effect','-djpeg')
 
%% Gnuplot Output
%    output_file_folder='.'; output_file_name=['size_effect_2D_m' num2str(p.rf_distribution.rmean) '_v' num2str(p.rf_distribution.rvariance) '_q' num2str(y_to_find) '.dat'];
%    f_write_gnuplot_output(output_file_folder, output_file_name, lengths', failure_stress');

