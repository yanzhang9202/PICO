%% PI Consensus Optimization
%  By Yan Zhang, 08/01/2018
clear;
close all;
clc;

PICO_start;

% Generate problem data
rnd_seed = 2;
rng(rnd_seed);

pb_type = 'randQP';
gen_problem;

% Run algorithms
ind_solver = [1,2,3,4]; % 1 - matlab    2 - extra   3 - conso
                       % 4 - pico
for ind = ind_solver
switch ind
    case 1
        main_matlab;
    case 2
        main_extra;
    case 3
        main_conso;
    case 4
        main_pico;
    otherwise
        error('Undefined algorithm!')
end
end

%% Save results
% save('results/080618_001');

% PICO_end;
