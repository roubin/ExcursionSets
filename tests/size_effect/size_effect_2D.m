%% Initial
clear all; addpath('../../routines');

%% th ELKC
input_file_folder='input'; input_file_name='lognormal_2D.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);


%% size effect
lengths=10.^(-3:0.1:1);
lengths=[0.001 0.8 2.5 8]
failure_stress=zeros(size(lengths));

%y_to_finds=[0.01 0.05 0.10 0.50 0.90 0.95 0.99];
y_to_finds=0.5;
for q=1:size(y_to_finds,2)
    y_to_find=y_to_finds(1,q);
    display(['quantile=' num2str(y_to_find)])
    for l=1:size(lengths,2)
        display(['  length=' num2str(lengths(1,l))])
        p.geometrical.size=lengths(1,l);
        th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

        %% Plot
        p.hitting_set.thresholds=f_set_thresholds(-3,2,0.01, 'log10');
        figure(1); semilogx(p.hitting_set.thresholds,th_elkc(2,p.hitting_set));
        figure(2); semilogx(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
        figure(3); semilogx(p.hitting_set.thresholds,th_elkc(0,p.hitting_set), [0.001 5], [0 0], '--k', [0.001 5], [1 1], '--r');
        

%        %% find maximum
%        n_lkc=0; x_zero=0.000000001; x_infi=100000;
%        func=@(t) -f_elkc(n_lkc, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t));
%        [x_max, y_max]=fminbnd(func,x_zero,x_infi); y_max=-y_max;
%        %display(['Find maximum value of LKC0: x_max=' num2str(x_max) ' y_max=' num2str(y_max)])

%        %% find zeros
%        problem.objective=@(t) f_elkc(n_lkc, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type',p.hitting_set.type,'thresholds',t)) - y_to_find;
%        problem.x0=[x_zero x_max];
%        problem.solver='fzero';
%        problem.options=optimset(@fzero);
%        [x_a,y_a]=fzero(problem); y_a=y_a+y_to_find;
%        %display(['Find first zero value of LKC0: x_a=' num2str(x_a) ' y_a=' num2str(y_a)])
%        %problem.x0=[x_max x_infi];
%        %[x_b,y_b]=fzero(problem); y_b=y_b+y_to_find;

%        plot(p.hitting_set.thresholds,th_elkc(n_lkc,p.hitting_set), x_max, y_max, '.', x_a, y_a, '+');
%        %plot(p.hitting_set.thresholds,th_elkc(n_lkc,p.hitting_set), x_max, y_max, '.', x_a, y_a, '+',  x_b, y_b, '+');
%        failure_stress(1,l)=x_a;    

        % Gnuplot Output
        output_file_folder='output'; output_file_name=['size_effect_2D_different_Euler_behaviors_l' num2str(lengths(1,l)) '.dat'];
        f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, th_elkc(0, p.hitting_set));

    
    end
%    loglog(lengths, failure_stress)

    % Gnuplot Output
%    output_file_folder='.'; output_file_name=['size_effect_2D_m' num2str(p.rf_distribution.rmean) '_v' num2str(p.rf_distribution.rvariance) '_q' num2str(y_to_find) '.dat'];
%    f_write_gnuplot_output(output_file_folder, output_file_name, lengths', failure_stress');

end
