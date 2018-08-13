%% Using matlab solver to solve the problem
switch pb_type
    case 'randQP'
        options = optimoptions('quadprog',...
        'Algorithm','interior-point-convex','Display','off');
    
        Qc = num2cell(Q, [1,2]);
        Hm = blkdiag(Qc{:});
        fm = q(:);
        um = u(:);  lm = l(:);
    
        [solm.x, solm.fval, solm.flagexit, solm.output, solm.lambda] = quadprog(...
            Hm, fm, [], [], [], [], lm, um, [], options);
        if solm.flagexit ~= 1
            error('Formulated problem cannot be exactly solved by Matlab!\n')
        end
        
        datam.H = Hm;   datam.f = fm;
        datam.l = lm;   datam.u = um;
        sol{ind_solver} = solm;
        clear Qc Hm Ac Am fm bm lm um solm;
    otherwise
        error('Undefined Matlab solution!')
end