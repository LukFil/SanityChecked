load('recon22.mat');
changeCobraSolver('glpk','all');
model = recon22;
RPMImediumSimulation;

checksArray(1, 1:16) = ones;

% Import the gene expression data
gxData = readtable('DATASET SenescenceGEM_ControlSen_geneExpressionData.txt');

% We need to choose whether we model the CONTROL or the SENESCENCE
% expression data. With the lines of coding below, we "separate" the
% control and senescence data
controlData    = gxData(:,[1,2,3,4]);
senescenceData = gxData(:,[1,2,3,5]);

% Create an index of all genes with expression of 0
indexControl = string(table2array(controlData(:,4))) == '0';
indexSenescence = string(table2array(senescenceData(:,4))) == '0';

% Remove genes with 0 expression from model
genesToRemoveControl = intersect(table2cell(controlData(indexControl,2)), modelRPMI.genes);
[modelRPMIcontrol, hasEffectControl, constrRxnNamesControl, deletedGenesControl] =... 
    deleteModelGenes(modelRPMI, genesToRemoveControl);

genesToRemoveSenescence = intersect(table2cell(senescenceData(indexSenescence,2)), modelRPMI.genes);
[modelRPMIsenescence, hasEffectSenescence, constrRxnNamesSenescence, deletedGenesSenescence] =... 
    deleteModelGenes(modelRPMI, genesToRemoveSenescence);

modelControl    = writeCbModel(modelRPMIcontrol, 'xls', 'modelRPMIcontrol');
modelSenescence = writeCbModel(modelRPMIsenescence, 'xls', 'modelRPMIsenescence');

sanityChecks(modelControl, checksArray, 'Control');
sanityChecks(modelSenescence, checksArray, 'Senescence');