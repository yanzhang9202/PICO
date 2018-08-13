%% Using matlab solver to solve the problem
switch pb_type
    case 'randQP'
        options = optimoptions('quadprog',...
        'Algorithm','interior-point-convex','Display','off');
    
        H = sum(Q,3);
        f = sum(q,2);
        um = u(:,1);  lm = l(:,1);
        
        % Without local constraints
        [solm.x, solm.fval, solm.flagexit, solm.output, solm.lambda] = quadprog(...
            H, f, [], [], [], [], [], [], [], options);
        if solm.flagexit ~= 1
            error('Formulated problem cannot be exactly solved by Matlab!\n')
        end
        
        datam.H = H;   datam.f = f;
        datam.l = lm;   datam.u = um;
        sol{ind} = solm;
        clear H f lm um solm;
    otherwise
        error('Undefined Matlab solution!')
end