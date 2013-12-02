%% Initial
clear all; addpath('../../routines');
input_file_folder='input';

%% th ELKC and derivatives
input_file_name='gaussian_2D.es';
p=f_read_input(input_file_folder, input_file_name);
p.hitting_set.thresholds=f_set_thresholds(-5,5,0.01);

elkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
delkc=@(j) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set, 'derivative');

%% Plot
figure(1); plot(p.hitting_set.thresholds,[elkc(2) delkc(2)], [-5 5], [0 0], '--k', [0 0], [-4000 10000], '--k');
figure(2); plot(p.hitting_set.thresholds,[elkc(1) delkc(1)], [-5 5], [0 0], '--k', [0 0], [-400 1000], '--k');
figure(3); plot(p.hitting_set.thresholds,[elkc(0) delkc(0)], [-5 5], [0 0], '--k', [0 0], [-30 40], '--k');


%% find zero ELKC0 by finding zero crossing on dELKC0
base10min=1; base10max=3;
lengths=f_set_thresholds(base10min, base10max, 0.01, 'log10');
x0=zeros(size(lengths));
length_first_solution=0.0;

for l=1:size(lengths,1)
    p.geometrical.size=lengths(l,1);
    display(['Size=' num2str(p.geometrical.size)])
    % define function that depend only on the the lkc number
    elkc=@(j)f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set);
    delkc=@(j)f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, p.hitting_set, 'derivative');
    
    
    % define function that depend on the the lkc number and the thresholds
    elkcx=@(j,x) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x));
    delkcx=@(j,x) f_elkc(j, p.geometrical, p.rf_distribution, p.rf_correlation, struct('type', p.hitting_set.type, 'thresholds', x), 'derivative');

    % research zone
    xmin=-100; xmax=100;    
    x_delkc_max_1=fminbnd(@(x) -delkcx(0,x), xmin, xmax);
    x_delkc_0_1=fzero(@(x) delkcx(0,x), x_delkc_max_1);
    x_delkc_max_2=fminbnd(@(x) -delkcx(0,x), x_delkc_0_1, xmax);
    x_delkc_0_2=fzero(@(x) delkcx(0,x), x_delkc_max_2);
    if(elkcx(0,x_delkc_0_2)<0)
        x_elkc_0_1=fzero(@(x) elkcx(0,x), [x_delkc_0_1 x_delkc_0_2]);
        x0(l)=x_elkc_0_1;
    else
        x_elkc_0_1=0.0;
    end    
    
    % root research of ELKC0 in order to split the research zone in two    
    figure(4); plot(p.hitting_set.thresholds,[elkc(0) max(abs(elkc(0)))*delkc(0)./max(abs(delkc(0)))], [x_delkc_max_1 x_delkc_max_1], [0 elkcx(0,x_delkc_max_1)],  [x_delkc_0_1 x_delkc_0_1], [0 elkcx(0,x_delkc_0_1)], [x_delkc_max_2 x_delkc_max_2], [0 elkcx(0,x_delkc_max_2)], [x_delkc_0_2 x_delkc_0_2], [0 elkcx(0,x_delkc_0_2)], [x_elkc_0_1 x_elkc_0_1], [min(elkc(0)) max(elkc(0))], [-5 5], [0 0], '--k'); legend('elck1', 'delkc1')
end

figure(5); semilogx(lengths, x0);
