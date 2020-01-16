function table = propChecks (model)


% changeCobraSolver('glpk','LP');
% warning off MATLAB:subscripting:noSubscriptsSpecified

%We first initialize the table

clear TableProp
r = 1;
TableProp(r, :) = {'Model'}; r = r+1;

%Determine the number of reactions in the model.

TableProp(r, 1) = {'Reactions'};
TableProp{r, 2} = num2str(length(model.rxns));
r = r + 1;

%Determine the number of metabolites in the model.

TableProp(r, 1) = {'Metabolites'};
TableProp{r, 2} = num2str(length(model.mets));
r = r + 1;

%Determine the number of unique metabolites in the model.

TableProp(r, 1) = {'Metabolites (unique)'};
[g, remR3M] = strtok(model.mets,'[');
TableProp{r, 2} = num2str(length(unique(g)));
r = r + 1;

%Determine the number of compartments in model.

TableProp(r, 1) = {'Compartments (unique)'};
TableProp{r, 2} = num2str(length(unique(remR3M)));
r = r + 1;

%Determine the number of unique genes.

TableProp(r, 1) = {'Genes (unique)'};
[g,rem]=strtok(model.genes,'.');
TableProp{r, 2} = num2str(length(unique(g)));
r = r + 1;

%Determine the number of subsystems.

TableProp(r, 1) = {'Subsystems'};
TableProp{r, 2} = num2str(length(unique(model.subSystems)));
r = r + 1;

%Determine the number of deadends.

TableProp(r, 1) = {'Deadends'};
D3M = detectDeadEnds(model);
TableProp{r, 2} = num2str(length(D3M));
r = r + 1;

%Determine the size of the S matrix.

TableProp(r, 1) = {'Size of S'};
TableProp{r, 2} = strcat(num2str(size(model.S,1)),'; ',num2str(size(model.S,2)));
r = r + 1;
%Determine the rank of S.

TableProp(r, 1) = {'Rank of S'};
TableProp{r, 2} = strcat(num2str(rank(full(model.S))));
r = r + 1;

%Determine the percentage of non-zero entries in the S matrix (nnz)

TableProp(r, 1) = {'Percentage nz'};
TableProp{r, 2} = strcat(num2str((nnz(model.S)/(size(model.S,1)*size(model.S,2)))));
r = r + 1;

%View table.

TableProp

%Name table

ControlProperties=TableProp

end