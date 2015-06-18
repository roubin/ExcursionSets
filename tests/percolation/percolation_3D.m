%% Initial
clear all; clc; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='gaussian_3D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-5,5,0.1);


%% percolation
lengths=f_set_thresholds(0,3,0.001, 'log10');
list_to_save=zeros(size(lengths,1),4);
for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    th_ec=@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
    th_vo=@(t) f_elkc(3, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t))./p.geometrical.size^3;
    
    %%% DETECT EXTREMA WITH PRECISION OF THE ARRAY (COARSE) %%%
    tr=p.hitting_set.thresholds;
    ec=th_ec(tr);
    [max_ec, min_ec]=peakdet(ec, 1e-14, tr);
    nmin=size(min_ec,1); nmax=size(max_ec,1);
    if(nmin==1 && nmax==2)
        if(min_ec(2)<0)
            display(['a=' num2str(1/p.geometrical.size)])
            %%% DETECT ZEROS WITH FZERO %%%
            [x01, y01]=fzero(th_ec,[max_ec(1,1), min_ec(1)]);
            [x02, y02]=fzero(th_ec,[max_ec(2,1), min_ec(1)]);
            %figure(1); plot(tr,th_vo(tr),[max_ec(:,1); min_ec(1)],[max_ec(:,2); min_ec(2)], '+r', [x01 x02],  [y01 y02], '*r', [min(tr) max(tr)], [0 0], '--k');
            list_to_save(l,1)=x01;
            list_to_save(l,2)=th_vo(x01);
            list_to_save(l,3)=x02;
            list_to_save(l,4)=th_vo(x02);
            %figure(2); semilogx(lengths, list_to_save(:,2), 'r-*', lengths, list_to_save(:,4), 'g-*')
        else
            display([' Specimen size to small for percolation theory. a=' num2str(1/p.geometrical.size)]);
        end
    else
        display([' Specimen size to small for percolation theory. a=' num2str(1/p.geometrical.size)]);
    end
    
    
end

%% Gnuplot Output
TAB=[lengths list_to_save];
TAB(TAB(:,2)==0,:)=[];
figure(3); semilogx(TAB(:,1), TAB(:,3), 'r-*', TAB(:,1), TAB(:,5), 'g-*')
output_file_folder='.'; output_file_name='output/percolation_3D.dat';
txt1='Scale ratio l/lc; threshold-; fraction volume-; threshold+; fraction volume+';
f_write_gnuplot_output(output_file_folder, output_file_name, TAB(:,1), TAB(:,2:5), txt1);

