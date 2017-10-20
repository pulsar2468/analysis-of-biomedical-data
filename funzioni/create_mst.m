function [mst,adjacency_matrix,e,outlier,error]=create_mst(Y,targets,perc,threshold_percentage,xtrain,xtest);
    %[ xtrain,xtest,nt ] = setsplit( Y,targets, perc );
    adjacency_matrix=distance_vector(xtrain{1});
    mst=graphminspantree(sparse(adjacency_matrix));
    [i,j]=find(mst);
    e=[];
    for ii=1:size(i)
        e(ii)=mst(i(ii),j(ii)); %pesi dell'Mst
    end
    %sprintf('Initial size\nTraining: %d\ntest: %d\nMst: %d\n',size(xtrain{1},1),size(xtest{1},1),size(mst,1))
    tic;
    [adjacency_matrix,e,outlier,len_training_set]=distance_vector_test(xtrain{1},xtest{1},e,adjacency_matrix,mst,threshold_percentage);
    %sprintf('Final size\nTraining: %d\nE: %d\nThreshold percentage: %d',len_training_set,size(e,2),threshold_percentage)
    error=(size(outlier,2)/2)/size(xtest{1},1)*100;
    %sprintf('Error: %d%%\nTime learning: %d\n\n\n',error,toc)
    sprintf('%d %d %d %d %d',size(xtrain{1},1),size(xtest{1},1),len_training_set,error,toc)
    

