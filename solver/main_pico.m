%% PI Consensus Optimization
alpha = 1e-2;   % Step size
iter_max = 2e3;
epsl = 1e-2;
w1 = gph.wgt';
w2 = (gph.wgt - eye(N))';

H = datam.H;
f = datam.f;

% Initiate var.
x0 = zeros(n, N);
x = zeros(n, N, iter_max);
x_avg = zeros(n, iter_max);
z_itr = zeros(n, N);

% Run
x(:,:,1) = x0;
x_avg(:,1) = sum(x0,2)/N;
x_itr = x(:,:,1);
for ii = 2 : iter_max
    temp_x = x_itr*w1;
    temp_z = z_itr*w2;
    for jj = 1 : N
        x(:,jj,ii) = temp_x(:,jj) + temp_z(:,jj) - alpha*(Q(:,:,jj)*x_itr(:,jj)... 
            +q(:,jj));        
    end
    z_itr = z_itr - x_itr*w2;
    
    x_itr = x(:,:,ii);
    x_avg(:,ii) = sum(x_itr,2)/N;
    rsd = norm(H*x_avg(:,ii) + f);
    if rsd < epsl
        fprintf(['PICO succeeds at iter. ', num2str(ii), ' with '...
            'accuracy ', num2str(rsd), '. \n\n'])
        break;
    else
       if mod(ii, 200) == 1
           fprintf(['PICO at iter. ', num2str(ii), ' with ',...
            'accuracy ', num2str(rsd), '...\n'])
       end
    end    
end

sol{ind}.x = x;
sol{ind}.x_itr = x_itr;
sol{ind}.x_avg = x_avg;
sol{ind}.z_itr = z_itr;
sol{ind}.eps = epsl;
sol{ind}.rsd = rsd;
sol{ind}.x0 = x0;
sol{ind}.alpha = alpha;
sol{ind}.num_itr = ii;

clear alpha epsl f H ii jj rsd temp_x temp_z w1 w2 x x0 x_avg x_itr z_itr
