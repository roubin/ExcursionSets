%% Initial
clear all; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='lognormal_3D.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);

% threshold research zone
p.hitting_set.thresholds=f_set_thresholds(-2,5,0.01, 'log10');


%% size effect
lengths=10.^(0.5:0.01:2);
%lengths=[0.001 0.8 2.5 8];
failure_stress=zeros(size(lengths));

%y_to_finds=[0.01 0.05 0.10 0.50 0.90 0.95 0.99];
y_to_finds=0.5;




for q=1:size(y_to_finds,2)
    y_to_find=y_to_finds(1,q);

    list_x01=0.0*lengths;
    list_x02=0.0*lengths;
    
    display(['quantile=' num2str(y_to_find)])
    for l=1:size(lengths,2)
        display(['  length=' num2str(lengths(1,l))])
        p.geometrical.size=lengths(1,l);
        
        th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

        % find maximum
        n_lkc=0; x_zero=min(p.hitting_set.thresholds); x_infi=max(p.hitting_set.thresholds);

        func=@(t) f_elkc(n_lkc, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
        [x_min, y_min]=fminbnd(func,x_zero,x_infi);
        %display(['Find minimum value of LKC0: x_min=' num2str(x_min) ' y_min=' num2str(y_min)])
        
        func=@(t) -f_elkc(n_lkc, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));      
        [x_max, y_max]=fminbnd(func,x_zero,x_min); y_max=-y_max;
        %display(['Find maximum value of LKC0: x_max=' num2str(x_max) ' y_max=' num2str(y_max)])

        
        if(sign(y_max*y_min)<0.0)
            [x_01, y_01]=fzero(func,[x_max x_min]);
            [x_02, y_02]=fzero(func,[x_min x_infi]);
            list_x01(l)=x_01;
            list_x02(l)=x_02;
            
            figure(3); semilogx(p.hitting_set.thresholds,-func(p.hitting_set.thresholds), [x_min x_min], [0 y_min], '--g', [x_max x_max], [0 y_max], '--r', [x_01 x_01], [y_01 y_01],'*r', [x_02 x_02], [y_02 y_02],'*r', [x_zero x_infi], [0 0], '--k');
        else
            figure(3); semilogx(p.hitting_set.thresholds,-func(p.hitting_set.thresholds), [x_min x_min], [0 y_min], '--g', [x_max x_max], [0 y_max], '--r', [0.001 100], [0 0], '--k');
        end

        
    end
    figure(4); loglog(lengths, list_x01, lengths, list_x02)

    %% Gnuplot Output
%    output_file_folder='.'; output_file_name=['size_effect_2D_m' num2str(p.rf_distribution.rmean) '_v' num2str(p.rf_distribution.rvariance) '_q' num2str(y_to_find) '.dat'];
%    f_write_gnuplot_output(output_file_folder, output_file_name, lengths', failure_stress');

end
