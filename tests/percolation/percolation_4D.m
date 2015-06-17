%% Initial
clear all; clc; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='gaussian_4D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-10,10,0.1);


%% percolation
lengths=f_set_thresholds(0,3,0.001, 'log10');
list_to_save12=zeros(size(lengths,1),4);
list_to_save34=zeros(size(lengths,1),4);
for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    th_ec=@(t) f_elkc(0, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
    th_vo=@(t) f_elkc(4, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t))./p.geometrical.size^4;
    display(['a=' num2str(1/p.geometrical.size)])
    
    %%% DETECT EXTREMA WITH PRECISION OF THE ARRAY (COARSE) %%%
    tr=p.hitting_set.thresholds;
    ec=th_ec(tr);    
    [max_ec, min_ec]=peakdet(ec, 1e-14, tr);    
    nmin=size(min_ec,1); nmax=size(max_ec,1);
    %display(['Nmax: ' num2str(nmax) ' Nmin: ' num2str(nmin)])
    if(nmax==1 && nmin==0)        
    elseif(nmax==2 && nmin==1)
    elseif(nmax==3 && nmin==2)
        %figure(1); plot(tr,th_ec(tr),[max_ec(:,1); min_ec(:,1)],[max_ec(:,2); min_ec(:,2)], '+r', [min(tr) max(tr)], [0 0], '--k');
        if(max_ec(1,2)*min_ec(1,2)<0)
            %display(' --> Roots 1&2: ok')
            [x01, y01]=fzero(th_ec,[max_ec(1,1), min_ec(1,1)]);
            [x02, y02]=fzero(th_ec,[min_ec(1,1), max_ec(2,1)]);
            %figure(1); plot(tr,th_ec(tr),[max_ec(:,1); min_ec(:,1)],[max_ec(:,2); min_ec(:,2)], '+r', [x01 x02],  [y01 y02], '*r', [min(tr) max(tr)], [0 0], '--k');
            list_to_save12(l,1)=x01;
            list_to_save12(l,2)=th_vo(x01);
            list_to_save12(l,3)=x02;
            list_to_save12(l,4)=th_vo(x02);
        else
            %display(' --> Roots 1&2: no')
        end
        
        if(max_ec(2,2)*min_ec(2,2)<0)
            %display(' --> Roots 3&4: ok')
            [x03, y03]=fzero(th_ec,[max_ec(2,1), min_ec(2,1)]);
            [x04, y04]=fzero(th_ec,[min_ec(2,1), max_ec(3,1)]);
            %figure(1); plot(tr,th_ec(tr),[max_ec(:,1); min_ec(:,1)],[max_ec(:,2); min_ec(:,2)], '+r', [x03 x04],  [y03 y04], '*r', [min(tr) max(tr)], [0 0], '--k');
            list_to_save34(l,1)=x03;
            list_to_save34(l,2)=th_vo(x03);
            list_to_save34(l,3)=x04;
            list_to_save34(l,4)=th_vo(x04);
        else
            %display(' --> Roots 3&4: no')
        end        
    else
        warning(['a=' num2str(1/p.geometrical.size) ' --> Unknown behavior'])
    end
    
    %figure(3); semilogx(lengths,list_to_save12(:,[2 4]), lengths,list_to_save34(:,[2 4]))
end

%% Gnuplot Output
TAB12=[lengths list_to_save12];
TAB12(TAB12(:,2)==0,:)=[];
TAB34=[lengths list_to_save34];
TAB34(TAB34(:,2)==0,:)=[];
figure(4); semilogx(TAB12(:,1), TAB12(:,3), 'r-*', TAB12(:,1), TAB12(:,5), 'g-*', TAB34(:,1), TAB34(:,3), 'r-+', TAB34(:,1), TAB34(:,5), 'g-+')
output_file_folder='.'; output_file_name='output/percolation_4D_roots12.dat';
txt1='Scale ratio l/lc; threshold-; fraction volume-; threshold+; fraction volume+';
f_write_gnuplot_output(output_file_folder, output_file_name, TAB12(:,1), TAB12(:,2:5), txt1);

output_file_folder='.'; output_file_name='output/percolation_4D_roots34.dat';
txt1='Scale ratio l/lc; threshold-; fraction volume-; threshold+; fraction volume+';
f_write_gnuplot_output(output_file_folder, output_file_name, TAB34(:,1), TAB34(:,2:5), txt1);

