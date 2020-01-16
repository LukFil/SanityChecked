load('recon22.mat');
changeCobraSolver('glpk','all');
model = recon22;
RPMImediumSimulation;

% Import the gene expression data
gxData = readtable('DATASET SenescenceGEM_ControlSen_geneExpressionData.txt');

% We need to choose whether we model the CONTROL or the SENESCENCE
% expression data. With the lines of coding below, we "separate" the
% control and senescence data
controlData    = gxData(:,[1,2,3,4]);
senescenceData = gxData(:,[1,2,3,5]);

controlData.Properties.VariableNames{'HGNC_ID'} = 'gene';
controlData.Properties.VariableNames{'Control_GeneExpression_Level'} = 'value';

% Assign reaction expressions
[expressionRxns, parsedGPR] = mapExpressionToReactions(modelRPMI, controlData);

meanExpression    = mean(expressionRxns);
standardDevExpr   = std (expressionRxns);

modelControl      = writeCbModel(modelRPMI, 'xls', 'modelRPMIcontrol');



upper = meanExpression + 1/2*(standardDevExpr);
lower = meanExpression - 1/2*(standardDevExpr);
iMAT (modelControl, expressionRxns, lower, upper)