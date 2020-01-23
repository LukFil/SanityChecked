load('GIMMEresults_BOTHconditions_glpk.mat');

% SANITY CHECKS
testChoice = ones(1, 16);
testChoice(1, 11) = 0;

sanCheckContr = sanityChecks(GIMME_modelControl,    testChoice, 'GIMMEcontrol_glpk');
sanCheckSenes = sanityChecks(GIMME_modelSenescence, testChoice, 'GIMMEsenescence_glpk');

clear
%%
load('GIMME_models_gurobi.mat');

testChoice = ones(1, 16);
testChoice(1, 11) = 0;

sanCheckContr = sanityChecks(GIMME_modelControl,    testChoice, 'GIMMEcontrol_gurobi');
sanCheckSenes = sanityChecks(GIMME_modelSenescence, testChoice, 'GIMMEsenescence_gurobi');