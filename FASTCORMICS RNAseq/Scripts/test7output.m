
C =  find(sum(mapping,2)>=(consensus_proportion*number_of_array_per_model)); 
B = find(ismember(model.rxns,optional_settings.func));

J = intersect( C, I );% fprintf('|J|=%d  ', length(J));
epsilon = 1e-6;
model = copyCmodel;
% INPUT : J model epsilon

nj = numel(J);
[m,n] = size(model.S)

% x = [v;z]

% objective
f = -[zeros(1,n), ones(1,nj)];

% equalities
Aeq = [model.S, sparse(m,nj)];
beq = zeros(m,1);

% inequalities
Ij = sparse(nj,n); 
Ij(sub2ind(size(Ij),(1:nj)',J(:))) = -1;
Aineq = sparse([Ij, speye(nj)]);
bineq = zeros(nj,1);

% bounds
lb = [model.lb; zeros(nj,1)];
ub = [model.ub; ones(nj,1)*epsilon];

% x = cplexlp(f,Aineq,bineq,Aeq,beq,lb,ub);
 
%% TEST gurobi

modelGuro.A          = sparse([Aineq; Aeq]);
modelGuro.obj        = f;
modelGuro.rhs        = [bineq; beq];
modelGuro.sense      = [repmat('<', 1, numel(bineq)) repmat('=', 1, numel(beq))];
modelGuro.modelsense = 'min';

x = gurobi(modelGuro)
