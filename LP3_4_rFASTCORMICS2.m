function V = LP3_4_rFASTCORMICS2( J, model )
%
% V = LP3( J, model )
%
% CPLEX implementation of LP-3 for input set J (see FASTCORE paper)

% (c) Nikos Vlassis, Maria Pires Pacheco, Thomas Sauter, 2013
%     LCSB / LSRU, University of Luxembourg


[m,n] = size(model.S);

% objective
f = zeros(1,n);
f(J) = -1;

% equalities
Aeq = model.S;
beq = zeros(m,1);

% bounds
lb = model.lb;
ub = model.ub;

modelGuro.A          = sparse([Aeq]);
modelGuro.obj        = f;
modelGuro.rhs        = [beq];
modelGuro.lb         = lb;
modelGuro.ub         = ub;
modelGuro.sense      = [repmat('=', 1, numel(beq))];
modelGuro.modelsense = 'min';

global xLP3;
xLP3 = gurobi(modelGuro);

V = xLP3.x;
end
