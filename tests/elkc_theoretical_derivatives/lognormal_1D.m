%% Initial
clear all; addpath('../../routines');
input_file_folder='input';

%% th ELKC and derivatives
input_file_name='lognormal_1D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-3, 3, 0.01, 'log10');
p=f_set_gauss_parameter(p);

elkc=@(j)  f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
delkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set, 'derivative');

%% Plot
figure(1); semilogx(p.hitting_set.thresholds,[elkc(1) delkc(1)], [0 1.5], [0 0], '--k', [0 0], [0 100], '--k'); legend('elck1', 'delkc1')
figure(2); semilogx(p.hitting_set.thresholds,[elkc(0) delkc(0)], [0 1.5], [0 0], '--k', [0 0], [0 6], '--k'); legend('elck0', 'delkc0')

%% find maximum of ELKC0 by finding zero crossing on dELKC0
base10min=-3; base10max=3;
lengths=f_set_thresholds(base10min, base10max, 0.01, 'log10');
x_max=zeros(size(lengths)); y_max=zeros(size(lengths));
length_first_solution=0.0;

for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    display(['Size=' num2str(p.geometrical.size)])
    % define function that depend only on the the lkc number
    elkc=@(j)f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    delkc=@(j)f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set, 'derivative');
    
    % define function that depend on the the lkc number qnd the thresholds
    elkcx=@(j,x) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x));
    delkcx=@(j,x) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x), 'derivative');

    % research zone
    xmin=0.001; xmax=1000;
    
    % test if solution in research zone
    if((delkcx(0,xmin)/delkcx(0,xmax))<0)
        x1=fzero(@(x) delkcx(0,x), [xmin xmax]);
        figure(3); semilogx(p.hitting_set.thresholds, [elkc(0), delkc(0)], x1, elkcx(0,x1), '+r', [xmin xmax], [0 0], '--k', [x1 x1], [min(delkc(0)) max(delkc(0))], '--k');
        x_max(l)=x1; y_max(l)=elkcx(0,x1);
        if(length_first_solution==0.0)
            length_first_solution=lengths(l);
        end
    else
        display(' ---> no solution')
        figure(3); semilogx(p.hitting_set.thresholds, [elkc(0), delkc(0)]);
    end
    %pause
end

display(['First solution for l=' num2str(length_first_solution) ' (ratio=' num2str(length_first_solution/p.rf_correlation.correlation_length) ').'])
figure(4); loglog(lengths, x_max);
figure(5); loglog(lengths, y_max);
figure(6); loglog(x_max, y_max);
