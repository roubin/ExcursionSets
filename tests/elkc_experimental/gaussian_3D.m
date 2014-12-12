%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='gaussian_3D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-4,4,0.01);
th_elkc=@(j,t) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, t);

%% read ref
rf_file_name='gaussian_random_field_3D.txt';
random_fields=f_read_random_field(input_file_folder, rf_file_name);

%% Experiment LKC
input_file_name='experimental_tail_2D.es';
p_ex=f_read_input(input_file_folder, input_file_name);
p_ex.hitting_set.thresholds=f_set_thresholds(-4,4,0.1);
ex_lkc=f_exp_lkc(random_fields, p_ex.hitting_set);

%% Plot
figure(1); plot(p.hitting_set.thresholds, th_elkc(2,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC2, '-+');
figure(2); plot(p.hitting_set.thresholds, th_elkc(1,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC1, '-+');
figure(3); plot(p.hitting_set.thresholds, th_elkc(0,p.hitting_set), p_ex.hitting_set.thresholds, ex_lkc.ELKC0, '-+');

%% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_th.dat'];
txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) '.'];
txt2='threshold ELKC0 ELKC1 ELKC2';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set), th_elkc(2, p.hitting_set)], txt1, txt2);
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_ex.dat'];
txt1=['Experimental LKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) '.'];
txt2='threshold min(LKC0) mean(LKC0) max(LKC1) min(LKC1) mean(LKC1) max(LKC1) min(LKC2) mean(LKC2) max(LKC2)';
f_write_gnuplot_output(output_file_folder, output_file_name, p_ex.hitting_set.thresholds, [ex_lkc.ELKC0, ex_lkc.ELKC1, ex_lkc.ELKC2], txt1, txt2);
