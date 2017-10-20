function [adjacency_matrix,e,outlier,len_training_set]=distance_vector_test(xtrain,xtest,e,adjacency_matrix,mst,perc_threshold);
outlier=[];
    adjacency_matrix_2=zeros(1,size(xtrain,1)); 
    h = waitbar(0,'learning');
    for i=1:size(xtest,1)
          waitbar(i/size(xtest,1))

        for j=1:size(xtrain,1)
                adjacency_matrix_2(1,j)=sqrt(sum((xtest(i,:) - xtrain(j,:)).^2)); %calcolo la distanza euclidea       
        end
        [value,index,e,node_outlier]=min_distance(adjacency_matrix_2,e,i+size(xtrain,1),perc_threshold);
        if (value>0)
            adjacency_matrix=[adjacency_matrix;adjacency_matrix_2];
            adjacency_matrix_2(1,end+1)=0;
            adjacency_matrix=[adjacency_matrix,adjacency_matrix_2'];
            xtrain=[xtrain;xtest(i,:)];
            %mst=graphminspantree(sparse(adjacency_matrix));
        else
            outlier(1,end+1:end+2)=node_outlier;

        end
    end
        close(h) 
        len_training_set=size(xtrain,1);
end