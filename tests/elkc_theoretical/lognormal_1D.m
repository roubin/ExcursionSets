%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name);

th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

%% Find max theoreticaly
s=sqrt(p.rf_distribution.variance);
mu=p.rf_distribution.mean;
beta=p.geometrical.size/p.rf_correlation.correlation_length;
xmax=exp(s*sqrt(pi)/beta+mu);
hs=p.hitting_set; hs.thresholds=xmax;
ymax=th_elkc(0,hs);



%% Plot
p.hitting_set.thresholds=f_set_thresholds(-2, 3, 0.01, 'log10');
figure(1); semilogx(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
figure(2); semilogx(p.hitting_set.thresholds,th_elkc(0,p.hitting_set), xmax, ymax, '+');


% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_T' num2str(p.geometrical.size) '_th.dat'];
txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', hitting set= ' num2str(p.hitting_set.type) ' mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) '.'];
txt2='threshold ELKC0 ELKC1';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set)], txt1, txt2);


