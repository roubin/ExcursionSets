%% Initial
clear all; addpath('../../routines');
input_file_folder='input';
output_file_folder='output';

%% th ELKC
input_file_name='lognormal_3D.es';
p=f_read_input(input_file_folder, input_file_name);

th_elkc=@(j,hs) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, hs);

%% Plot
p.hitting_set.thresholds=f_set_thresholds(-5, 5, 0.01, 'log10');
figure(1); semilogx(p.hitting_set.thresholds,th_elkc(3,p.hitting_set));
figure(2); semilogx(p.hitting_set.thresholds,th_elkc(2,p.hitting_set));
figure(3); semilogx(p.hitting_set.thresholds,th_elkc(1,p.hitting_set));
figure(4); semilogx(p.hitting_set.thresholds,th_elkc(0,p.hitting_set));


a=th_elkc(3,p.hitting_set);

% Gnuplot Output
output_file_name=[p.rf_distribution.type '_' num2str(p.geometrical.spatial_dimension) 'D_Lc' num2str(p.rf_correlation.correlation_length) '_' num2str(p.geometrical.sizeX) 'x' num2str(p.geometrical.sizeY) 'x' num2str(p.geometrical.sizeZ) '_th.dat'];
txt1=['Theoretical ELKC ' num2str(p.geometrical.spatial_dimension) 'D with distribution=' p.rf_distribution.type ', hitting set= ' num2str(p.hitting_set.type) ' mean=' num2str(p.rf_distribution.mean) ', v=' num2str(p.rf_distribution.variance) ', Lc=' num2str(p.rf_correlation.correlation_length) ' in a cube of size ' num2str(p.geometrical.sizeX) 'x' num2str(p.geometrical.sizeY) 'x' num2str(p.geometrical.sizeZ) '.'];
txt2='threshold ELKC0 ELKC1 ELKC2 ELKC3';
f_write_gnuplot_output(output_file_folder, output_file_name, p.hitting_set.thresholds, [th_elkc(0, p.hitting_set), th_elkc(1, p.hitting_set), th_elkc(2, p.hitting_set), th_elkc(3, p.hitting_set)], txt1, txt2);
