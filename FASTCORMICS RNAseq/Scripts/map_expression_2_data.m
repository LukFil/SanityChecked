function [mapping, mapped_to_genes] = map_expression_2_data(model, data, dico, rownames)
%% Maria Pires Pacheco & Thomas Sauter 25.03.2014 - System biology group % University of Luxembourg
% slighty adapted for dico as table input
%% search the rownames in the dictionnary
col = find(sum(ismember(table2array(dico),rownames)));
[~,IA,loc] = intersect(table2array(dico(:,col)),rownames);

if isempty(loc);
    'the dico does match the dataIds';
    return
end

global seeLoc seeIA seeMapped1 seeMapping0 seeMapping1 seeMapped2;
seeLoc = loc;
seeIA = IA;

mapped2(:,1) = rownames(loc,1);
mapped2(:,2) = table2array(dico(IA,1));
mapped2(:,3) = table2array(dico(IA,2));
mapped = data(loc,:);

seeMapped2 = mapped2;
seeMapped1 = mapped;

mapped_to_genes = zeros(numel(model.genes), size(mapped,2)); %initialise variable
global matchArray

% maps the expression data to the genes
for i=1:numel(model.genes);
    match = find(strcmp(mapped2(:,2),model.genes(i)));
    matchArray = match;
    if numel(match)==1;
        mapped_to_genes(i,:)=mapped(match,:);
    elseif isempty(match);
        
    else
        mapped_to_genes(i,:)=max(mapped(match,:),[],1); % take the highest value if
        %more probeIDs correspond to one modelID
    end
end

global mapToGene;
mapToGene = mapped_to_genes;

% maps the expression data to the reactions
mapping = zeros(numel(model.rxns), size(mapped,2));
seeMapping0 = mapping;
for j= 1:size(mapped_to_genes,2)
    x=mapped_to_genes(:,j);
    for k=1:numel(model.rxns);
        mapping(k,j)= GPRrulesMapper(cell2mat(model.rules(k)),x);
    end
end
seeMapping1 = mapping;
end


