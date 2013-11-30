%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% 
input_file_name='lognormal_tail.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);
p.hitting_set.thresholds=f_set_thresholds(-3,2,0.01, 'log10');

gmf=@(k) f_gaussian_minkowski_functionals(k,p.rf_distribution,p.hitting_set);

gmf=[gmf(0) gmf(1) gmf(2) gmf(3)];


%% Plot
figure(1); semilogx(p.hitting_set.thresholds, gmf);
legend('gmf0','gmf1', 'gmf2', 'gmf3')

%% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' p.hitting_set.type '.dat'];
txt1=['Theoretical GMF with distribution=' p.rf_distribution.type ', hittingset=' num2str(p.hitting_set.type) ', mean=' num2str(p.rf_distribution.mean) ' and v=' num2str(p.rf_distribution.variance) '.'];
txt2='threshold GMF0 GMF1 GMF2 GMF3';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, gmf, txt1, txt2);


%%%%%%
%%%%%%


%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% 
input_file_name='lognormal_cumulative.es';
p=f_read_input(input_file_folder, input_file_name);
p=f_set_gauss_parameter(p);
p.hitting_set.thresholds=f_set_thresholds(-3,2,0.01, 'log10');

gmf=@(k) f_gaussian_minkowski_functionals(k,p.rf_distribution,p.hitting_set);

gmf=[gmf(0) gmf(1) gmf(2) gmf(3)];


%% Plot
figure(1); semilogx(p.hitting_set.thresholds, gmf);
legend('gmf0','gmf1', 'gmf2', 'gmf3')

%% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' p.hitting_set.type '.dat'];
txt1=['Theoretical GMF with distribution=' p.rf_distribution.type ', hittingset=' num2str(p.hitting_set.type) ', mean=' num2str(p.rf_distribution.mean) ' and v=' num2str(p.rf_distribution.variance) '.'];
txt2='threshold GMF0 GMF1 GMF2 GMF3';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, gmf, txt1, txt2);

