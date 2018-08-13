%% Extra solver by W.Shi
alpha = 1e-2;   % Step size
iter_max = 2e3;
epsl = 1e-2;
w1 = gph.wgt';
w2 = w1 - (gph.wgt + eye(N))'/2;

H = datam.H;
f = datam.f;

% Initiate var.
x0 = zeros(n, N);
x = zeros(n, N, iter_max);
x_avg = zeros(n, iter_max);
intgral = zeros(n, N);

% Run
x(:,:,1) = x0;
x_avg(:,1) = sum(x0,2)/N;
temp = x0*w1;
for jj = 1 : N
    x(:,jj,2) = temp(:,jj) - alpha*(Q(:,:,jj)*x0(:,jj)+q(:,jj));
end
intgral = intgral + x0*w2;
x_itr = x(:,:,2);
x_avg(:,2) = sum(x_itr,2)/N;
for ii = 3 : iter_max
    temp = x_itr*w1;
    for jj = 1 : N
        x(:,jj,ii) = temp(:,jj) - alpha*(Q(:,:,jj)*x_itr(:,jj)... 
            +q(:,jj)) + intgral(:,jj);
    end
    intgral = intgral + x_itr*w2;
    x_itr = x(:,:,ii);
    
    x_avg(:,ii) = sum(x_itr,2)/N;   
    rsd = norm(H*x_avg(:,ii) + f);
    if rsd < epsl
        fprintf(['Extra succeeds at iter. ', num2str(ii), ' with '...
            'accuracy ', num2str(rsd), '. \n\n'])
        break;
    else
       if mod(ii, 10) == 1
           fprintf(['Extra at iter. ', num2str(ii), ' with ',...
            'accuracy', num2str(rsd), '...\n'])
       end
    end
end
