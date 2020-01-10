function [messageOut] = buildFluxDistLayoutDiff(model, solution1, solution2, identifier)
% Builds a layout for MINERVA from the difference in flux distribution
%  between two COBRA solutions. 
%
% USAGE:
%
%    [messageOut] = buildFluxDistLayout(model, solution1, solution2, identifier)
%
% INPUTS:
%    model:             COBRA model structure
%    solution1:         optimizeCb solution structure with a flux vector
%    solution2:         optimizeCb solution structure with a flux vector
%    identifier:        Name for the layout in MINERVA
%
% OUTPUT:
%    messageOut:        message!
%
% .. Author: Michiel Adriaens (14-06-2018)

content = 'name\treactionIdentifier\tlineWidth\tcolor\n';
for i=1:length(solution1.v)
    mapReactionId = model.rxns{i};
    % Both negative
    if solution1.v(i) < 0 && solution2.v(i) < 0
        if solution1.v(i) < solution2.v(i) % stronger negative flux
            line = strcat('\t', mapReactionId, '\t', 5, '\t', '#FFD700', '\n'); % gold
            content = strcat(content, line);
        end
        if solution1.v(i) > solution2.v(i) % weaker negative flux
            line = strcat('\t', mapReactionId, '\t', 5, '\t', '#1E90FF', '\n'); % blue
            content = strcat(content, line);
        end
    end
    
    % Both positive
    if solution1.v(i) > 0 && solution2.v(i) > 0
        if solution1.v(i) > solution2.v(i) % stronger positive flux
            line = strcat('\t', mapReactionId, '\t', 5, '\t', '#FFD700', '\n'); % gold
            content = strcat(content, line);
        end
        if solution1.v(i) < solution2.v(i) % weaker positive flux
            line = strcat('\t', mapReactionId, '\t', 5, '\t', '#1E90FF', '\n'); % blue
            content = strcat(content, line);
        end
    end
    
    % Positive versus negative
    if solution1.v(i) > 0 && solution2.v(i) < 0
        line = strcat('\t', mapReactionId, '\t', 5, '\t', '#7c6c5a', '\n'); % taupe
        content = strcat(content, line);
    end
    
    % Negative versus positive
    if solution1.v(i) < 0 && solution2.v(i) > 0
        line = strcat('\t', mapReactionId, '\t', 5, '\t', '#7c6c5a', '\n'); % taupe
        content = strcat(content, line);
    end
end

% Modified code of buildFluxDistLayout to export overlay to upload manually:
fileID = fopen(strcat(identifier, '_diff_overlay.txt'), 'w');
fprintf(fileID, content);
fclose(fileID);
serverResponse = 'done';
end