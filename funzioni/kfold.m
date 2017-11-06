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
% %For overfitting with cross-validtion k fold
% 
% [Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_elegans.fas'); %rappresentation of data with k-meri
% [xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers
% 
% k_fold=[2:9];
% for i = 1:size(k_fold,2)
%     
%     cvp = cvpartition(size(xdataset{1},1),'Kfold',k_fold(i)); % kfold
%     for j=1:cvp.NumTestSets
%     %index training and test set
%     trainingIdx = cvp.training(j);
%     testIdx = cvp.test(j);
%     
%     %training and test set
%     xtrain={xdataset{1}(trainingIdx,:)};
%     xtest={xdataset{1}(testIdx,:)};
%     
%     
%     %fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(j),cvp.TestSize(j),j)
%     %fprintf('Training-set %d Test-set:%d\n',(cvp.TrainSize(j)/cvp.NumObservations)*100,(cvp.TestSize(j)/cvp.NumObservations)*100)
% 
%     %for threshold, in the min_distance, you change the condition Remember it!
%     threshold_percentage=[50,70,95];
%     for c=1:size(threshold_percentage,2)
%     [mst,adjacency_matrix,e,outlier,error]=create_mst(Y,targets,0,threshold_percentage(c),xtrain,xtest);
% %     if error < 0.2
% %         break
% %     end
%     end
%     end
% end


%For overfitting with cross-validtion k fold. Training with nucleosoma, but
%testing of linker of the same family

[Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_melanogaster.fas'); %rappresentation of data with k-meri
[xdataset,xtestset,xnt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers
%[Y,targets]=map_nucleosomi('nucleosomes_vs_linkers_sapiens.fas'); %rappresentation of data with k-meri
%[ydataset,ytestset,ynt ] = setsplit( Y,targets, 1); % i divide  dataset into two sets nucleosomes and linkers

    %cvv = cvpartition(size(ydataset{1},1),'Kfold',10); % kfold

k_fold=[2:9];%%%%%%%%%%%%%%
tr_value=[2,1.428,1.15];
for i = 1:size(k_fold,2)
    
    cvp = cvpartition(size(xdataset{1},1),'Kfold',k_fold(i)); % kfold
    for j=1:cvp.NumTestSets
    %index training and test set
    trainingIdx = cvp.training(j);
    testIdx = cvp.test(j);
    
    %training and test set
    xtrain={xdataset{1}(trainingIdx,:)};
    %xtest={ydataset{1}([1:150],:)}; %% from another nucleosome sequences
    xtest={xdataset{1}(testIdx,:)}; 

    
    %fprintf('Test with Training-set: %d Test-set: %d K-fold: %d\n',cvp.TrainSize(j),cvp.TestSize(j),j)
    %fprintf('Training-set %d Test-set:%d\n',(cvp.TrainSize(j)/cvp.NumObservations)*100,(cvp.TestSize(j)/cvp.NumObservations)*100)
    for c=1:size(tr_value,2)
    [mst,adjacency_matrix,e,outlier,error]=create_mst(xtrain,xtest,tr_value(c));
%     if error < 0.2
%         break
%     end
    end
    end
end