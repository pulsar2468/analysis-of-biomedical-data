function [ xtrain,xtest,nt ] = setsplit( X,targets, perc )
%Divide un dataset X in training e test secondo una percentuale perc.
%Inputs:
%X matrice del dataset elementi x carattersitiche
%targets: etichette di classe
%perc: percentuale di elementi di X da considerare come test
%Ouputs:
%xtrain: vettore cella che contiene gli elementi di training
%xtest: vettore cella che contiene gli elementi di test
%nt è il numero di elementi di training per ogni classe
%Il training avrà size(X,1)*perc elementi, il test i rimanenti.
%xtrain, xtest sono vetori cella di training e test
%rispettivamente tali che xtrain{j} (xtest{j}) sono gli elementi di training
%(test) di classe j. 

V=targets;
if iscell(targets)
    V=cell2mat(targets);
end

l=unique(V);
nc = length(unique(V));

xtrain={};
xtest={};
nt=zeros(1,nc);
%vengono riassegnate le label di classe
for i=1:nc
 I=find(V==l(i));
 R=randperm(length(I));  
 nt(i)=round(perc*length(R));
 xtrain{i}=X(I(R(1:nt(i))),:);
 xtest{i}=X(I(R(nt(i)+1:end)),:);
end


 

