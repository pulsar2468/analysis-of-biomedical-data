function [mst,adjacency_matrix,e,outlier,error]=create_mst(xtrain,xtest,tr_value,linker);
    %[ xtrain,xtest,nt ] = setsplit( Y,targets, perc );
    
    adjacency_matrix=distance_vector(xtrain{1});
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %For cosine similarity%
    %%This is very important. Since not exist the function max span tree, I
    %%invert element by element in the adjacency matrix. In this way, it
    %%computes the minimum spanning tree that equivalent to max spanning
    %%tree ( use only with cosine similarity of course!! )
    %adjacency_matrix=cosine_similarity(xtrain{1});
    %adjacency_matrix(:)= 1 - adjacency_matrix(:);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    mst=graphminspantree(sparse(adjacency_matrix));
    [i,j]=find(mst);
    e=[];
    for ii=1:size(i)
        e(ii)=mst(i(ii),j(ii)); %pesi dell'Mst
    end
    e=sort(e); %% sorting for the median calcule
    %sprintf('Initial size\nTraining: %d\ntest: %d\nMst: %d\n',size(xtrain{1},1),size(xtest{1},1),size(mst,1))
    tic;
    [adjacency_matrix,e,outlier,len_training_set]=distance_vector_test(xtrain{1},xtest{1},e,adjacency_matrix,tr_value);
    %[adjacency_matrix,e,outlier,len_training_set]=cosine_similarity_test(xtrain{1},xtest{1},e,adjacency_matrix,tr_value);
    %end learning, now i try to get specivity for linker sequence
    true_positive=len_training_set;
    sensivity=(true_positive/(size(xtrain{1},1) + size(xtest{1},1)))*100;
    %error=(size(outlier,2)/2)/size(xtest{1},1)*100;
    [adjacency_matrix,e,outlier,len_training_set_withLinker]=distance_vector_test(xtrain{1},linker{2},e,adjacency_matrix,tr_value);
    false_positive = len_training_set_withLinker-len_training_set;
    true_negative = size(linker{2},1) - false_positive;
    specivity= (true_negative/(true_negative + false_positive))*100;
    accuracy= 100*((true_positive + true_negative) / (true_negative + size(xtrain{1},1) + size(xtest{1},1) + false_positive));
    %error=1-accuracy;
    sprintf('%d %d %d %d %d %d %d %d %d',size(xtrain{1},1),size(xtest{1},1),len_training_set,sensivity,specivity,accuracy,toc,tr_value)
    

