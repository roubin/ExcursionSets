%% Initial
clear all; addpath('../../routines');

%% th ELKC and derivatives
input_file_folder='.'; input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(0.01,1.5,0.01);
p=f_set_gauss_parameter(p);

elkc=@(j)              f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
delkc=@(j) f_elkc_derivatives(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);

%% Plot
figure(1); plot(p.hitting_set.thresholds,[elkc(1) delkc(1)], [0 1.5], [0 0], '--k', [0 0], [0 100], '--k'); legend('elck1', 'delkc1')
figure(2); plot(p.hitting_set.thresholds,[elkc(0) delkc(0)], [0 1.5], [0 0], '--k', [0 0], [0 6], '--k'); legend('elck0', 'delkc0')

%% find maximum

lengths=10.^(-3:0.01:3);
x_max=zeros(size(lengths));
y_max=zeros(size(lengths));

for l=1:size(lengths,2)
    p.geometrical.size=lengths(1,l);
    display(['Size=' num2str(p.geometrical.size)])
    elkc=@(j)f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    delkc=@(j)f_elkc_derivatives(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    
    elkcx=@(j,x) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x));
    delkcx=@(j,x) f_elkc_derivatives(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x));

    xmin=1e-6;
    xmax=1e3;
    
    if((delkcx(0,xmin)/delkcx(0,xmax))<0)
        x1=fzero(@(x) delkcx(0,x), [0.000001 10000]);
%        figure(2); plot(p.hitting_set.thresholds, elkc(0), x1, elkcx(0,x1), '+r');
        x_max(l)=x1;
        y_max(l)=elkcx(0,x1);
    else
%        display(' ---> no solution')
%        figure(2); plot(p.hitting_set.thresholds, elkc(0));
    end
       
end

figure(3); loglog(lengths, x_max);
figure(4); loglog(lengths, y_max);
figure(5); loglog(x_max, y_max);