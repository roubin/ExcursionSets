%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-2, 3, 0.01,'log10');
%p.hitting_set.thresholds=f_set_thresholds(0.01, 40, 0.01);
th_elkc=@(j,t) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, t);

%% read ref
rf_file_name='gaussian_random_field_1D.txt';
random_fields=f_read_random_field(input_file_folder, rf_file_name);
random_fields.Values=exp(random_fields.Values);

%% Experiment LKC
input_file_name='lognormal_1D.es';
p_ex=f_read_input(input_file_folder, input_file_name);
p_ex.hitting_set.thresholds=f_set_thresholds(-2, 3, 0.01, 'log10');
%p_ex.hitting_set.thresholds=f_set_thresholds(0.1, 40, 1);
ex_lkc=f_exp_lkc(random_fields, p_ex.hitting_set);

%% Plot
figure(1); plot(random_fields.Points, random_fields.Values)
figure(2); semilogx(p.hitting_set.thresholds, th_elkc(1,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC1, '-+');
figure(3); semilogx(p.hitting_set.thresholds, th_elkc(0,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC0, '-+');
%figure(2); plot(p.hitting_set.thresholds, th_elkc(1,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC1, '-+');
%figure(3); plot(p.hitting_set.thresholds, th_elkc(0,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC0, '-+');


%% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_th.dat'];
txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) '.'];
txt2='threshold ELKC0 ELKC1';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set)], txt1, txt2);
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_ex__SingleRea_2.dat'];
txt1=['Experimental LKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) '.'];
txt2='threshold min(LKC0) mean(LKC0) max(LKC1) min(LKC1) mean(LKC1) max(LKC1)';
f_write_gnuplot_output(output_file_folder, output_file_name, p_ex.hitting_set.thresholds, [ex_lkc.ELKC0, ex_lkc.ELKC1], txt1, txt2);
