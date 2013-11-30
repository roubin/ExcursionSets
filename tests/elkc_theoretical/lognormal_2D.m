%% Initial
clear all; addpath('../../routines');

%% th ELKC
input_file_folder='.'; input_file_name='lognormal_2D.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);

th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

%% Plot
p.hitting_set.thresholds=f_set_thresholds(0.01,2,0.01);
figure(1); plot(p.hitting_set.thresholds,th_elkc(2,p.hitting_set));
figure(2); plot(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
figure(3); plot(p.hitting_set.thresholds,th_elkc(0,p.hitting_set));


% Gnuplot Output
output_file_folder='.'; output_file_name=['lognormal_2D_Lc' num2str(p.rf_correlation.correlation_length) '.dat'];
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set)]);
