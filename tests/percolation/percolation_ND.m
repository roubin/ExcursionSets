%% Initial
clear all; clc; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='gaussian_ND.es';
p=f_read_input(input_file_folder, input_file_name);
p.geometrical.spatial_dimension=10;
p.hitting_set.thresholds=f_set_thresholds(-10,10,0.1);


%% percolation
lengths=f_set_thresholds(-1,3,0.01, 'log10');
list_to_save=zeros(size(lengths,1),2);
for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    th_ec=@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
    th_vo=@(t) f_elkc(p.geometrical.spatial_dimension, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t))./p.geometrical.size^p.geometrical.spatial_dimension;
    display(['a=' num2str(1/p.geometrical.size)])
    
    %%% DETECT EXTREMA WITH PRECISION OF THE ARRAY (COARSE) %%%
    tr=p.hitting_set.thresholds;
    ec=th_ec(tr);
    [max_ec, min_ec]=peakdet(ec, 1e-14, tr);
    %figure(1); plot(tr,th_ec(tr));
    if(size(min_ec)>1)
        if(max_ec(end,2)*min_ec(end,2)<0)
            [x01, y01]=fzero(th_ec,[min_ec(end,1), max_ec(end,1)]);
            %figure(2); plot(tr,th_ec(tr),[max_ec(:,1); min_ec(:,1)],[max_ec(:,2); min_ec(:,2)], '+r', x01, y01, '*r', [min(tr) max(tr)], [0 0], '--k');
            list_to_save(l,1)=x01;
            list_to_save(l,2)=th_vo(x01);
        end
    end
    
    figure(3); semilogx(lengths,list_to_save(:,2));
end

%% Gnuplot Output
TAB=[lengths list_to_save];
TAB(TAB(:,2)==0,:)=[];
figure(4); semilogx(TAB(:,1), TAB(:,3), 'r-*');
output_file_folder='.'; output_file_name=['output/percolation_' num2str(p.geometrical.spatial_dimension) 'D_lastRoot.dat'];
txt1='Scale ratio l/lc; threshold+; fraction volume+';
f_write_gnuplot_output(output_file_folder, output_file_name, TAB(:,1), TAB(:,2:3), txt1);