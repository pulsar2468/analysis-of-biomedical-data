[Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_melanogaster.fas'); %rappresentation of data with k-meri
[xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers

cvp = cvpartition(size(xdataset{1},1),'Kfold', 10) % kfold

for i = 1:cvp.NumTestSets
    
    %index training and test set
    trainingIdx = cvp.training(i);
    testIdx = cvp.test(i);
    
    %training and test set
    xtrain={xdataset{1}(trainingIdx,:)};
    xtest={xdataset{1}(testIdx,:)};
    
    
    fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(i),cvp.TestSize(i),i)
    %for threshold, in the min_distance, you change the condition Remember it!
    [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,0,0,xtrain,xtest);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%with others dataset
% [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas'); %rappresentation of data with k-meri
% [xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers
% [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_sapiens.fas'); %rappresentation of data with k-meri
% [ydataset,ytestset,ynt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers
% 
% 
% cvp = cvpartition(size(xdataset{1},1),'Kfold', 10) % kfold
% cvy = cvpartition(size(ydataset{1},1),'Kfold', 10) % kfold
% 
% for i = 1:1 %cvp.NumTestSets
%     
%     %index training and test set
%     trainingIdx = cvp.training(i);
%     testIdx = cvy.test(i);
%     
%     %training and test set
%     xtrain={xdataset{1}(trainingIdx,:)};
%     ytest={ydataset{1}(testIdx,:)};
%     
%     
%     fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(i),cvp.TestSize(i),i)
%     %for threshold, in the min_distance, you change the condition Remember it!
%     [mst,adjacency_matrix,e,outlier]=create_mst(Y,targets,0,40,xtrain,ytest);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For overfitting incomplete

% [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas'); %rappresentation of data with k-meri
% [xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers
% 
% k_fold=[3];
% for i = 1:size(k_fold,2)
%     cvp = cvpartition(size(xdataset{1},1),'Kfold',k_fold(i)) % kfold
%     %index training and test set
%     trainingIdx = cvp.training(i);
%     testIdx = cvp.test(i);
%     
%     %training and test set
%     xtrain={xdataset{1}(trainingIdx,:)};
%     xtest={xdataset{1}(testIdx,:)};
%     
%     
%     fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(1),cvp.TestSize(1),i)
%     %for threshold, in the min_distance, you change the condition Remember it!
%     [mst,adjacency_matrix,e,outlier,error]=create_mst(Y,targets,0,0,xtrain,xtest);
%     if error < 0.2
%         break
%     end
% end