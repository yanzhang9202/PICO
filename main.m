%% PI Consensus Optimization
%  By Yan Zhang, 08/01/2018
clear;
close all;
clc;

PICO_start;

% Generate problem data
rnd_seed = 1;
rng(rnd_seed);

pb_type = 'randQP';
gen_problem;

% Run algorithms
ind_solver = 1; % 1 - matlab    2 - extra   3 - pico
switch ind_solver
    case 1
        main_matlab;
    case 2
        main_extra;
    otherwise
        error('Undefined algorithm!')
end

%% Save results
% save('results/080618_001');

% PICO_end;
