%% Extra solver by W.Shi
alpha = 1e-2;   % Step size
iter_max = 1e3;

w1 = gph.wgt;
w2 = (gph.wgt + eye(N))/2;
