%Comparison training and test set at the same dataset (example only
%elegans)
% n=[20:20:80]; %THRESHOLD value
% percen_train=[.9];


% for i=1:size(percen_train,2)
%     [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_sapiens.fas');
%     [xtrain,xtest,xnt ] = setsplit( Y,targets, percen_train(i));
%     for j=1:size(n,2)
%         fprintf('Test with Training-set: %d Test-set: %d Threshold: %d\n',percen_train(i)*100,100-percen_train(i)*100,n(j))
%         %for threshold, in the min_distance, you change the condition Remeber it!
%         [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,percen_train(i),n(j),xtrain,xtest);
%     end
% end 


%Comparison with others dataset of size 70-30, 80-20, 90-10
% n=[20:20:80]; %THRESHOLD value
% percen_train=[.9];
% for i=1:size(percen_train,2)
%     [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas');
%     [xtrain,xtest,xnt ] = setsplit( Y,targets, percen_train(i) );
%     [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_sapiens.fas');
%     [ytrain,ytest,ynt ] = setsplit( Y,targets, percen_train(i) );
%         
%         fprintf('Test with Training-set Elegans: %d Test-set Sapiens: %d Threshold: %d\n',percen_train(i)*100,100-percen_train(i)*100,0)
%         [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,percen_train(i),0,xtrain,ytest);
% end


% n=[20:20:80]; %THRESHOLD value
% percen_train=[.9];
% [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas');
% [xtrain,xtest,xnt ] = setsplit( Y,targets, percen_train(1) );
% for i=1:size(percen_train,2)
%  fprintf('Test with Training-set Elegans: %d Test-set Sapiens: %d Threshold: %d\n',percen_train(i)*100,100-percen_train(i)*100,0)
%  [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,percen_train(i),0,xtrain,xtest);
% end

[Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas'); %rappresentation of data with k-meri
[xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers

cvp = cvpartition(size(xdataset{1},1),'Kfold', 10) % kfold

for i = 1:cvp.NumTestSets
    
    %index training and test set
    trainingIdx = cvp.training(i);
    testIdx = cvp.test(i);
    
    %training and test set
    xtrain={xdataset{1}(trainingIdx)};
    xtest={xdataset{1}(testIdx)};
    
    
    fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(i),cvp.TestSize(i),cvp.NumTestSets)
    %for threshold, in the min_distance, you change the condition Remember it!
    [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,0,0,xtrain,xtest);
end