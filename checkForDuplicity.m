%% See whether there is a repetition of reactions in the source
%  Relevant information
%  Variables:
%  holdTempor - should be assigned a model, one that is already in the form
%               which is later used in the test that is requiring the
%               reactions to be unique
%  numbOfDupl - a simple INTEGER variable which gives information about
%               whether there are replications at all
%  recordDupl - a 2-dimensional array of elements, containing information
%               about which reactions are duplicated, and how many times
%               Names of the reactions are stored in the collumn 1, the
%               number of replications in the collumn 2
%

holdTempor = modelControlClosed;          % Needs to be assigned ACTUAL value
numbOfDupl = 0;

recordDupl(1, 1) = "Name of reaction";
recordDupl(1, 2) = "Number of duplications"; 

[rowsRxns, colsRxns] = size (holdTempor.rxns);

for (n1 = 1:rowsRxns)
    for (n2 = 1:rowsRxns)        
        if (isequal(holdTempor.rxns{n1, :}, holdTempor.rxns{n2, :}) && n1 ~= n2)
            numbOfDupl = numbOfDupl + 1;
            
            % See if the result table already contains the reaction
            % If not, append the reaction at the end.
            
            assigned     = false;
            [rows, cols] = size (recordDupl);
            
            for (n3 = 1:rows)
                if (isequal(holdTempor.rxns(n1),recordDupl(n3, 1)))
                    recordDupl(n3, 2) = recordDupl(n3, 2) + 1;
                    assigned = true;
                elseif (n3 == rows && assigned == false)
                    recordDupl(rows + 1, 1) = holdTempor.rxns(n1);
                    recordDupl(rows + 1, 2) = 1;
                end
            end          
        end        
    end    
end

recordDupl