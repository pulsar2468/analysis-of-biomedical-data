function [adjacency_matrix,e,outlier,len_training_set]=cosine_similarity_test(xtrain,xtest,e,adjacency_matrix,tr_value);
outlier=[];
    adjacency_matrix_2=zeros(1,size(xtrain,1)); 
   % h = waitbar(0,'learning');
    for i=1:size(xtest,1)
          %waitbar(i/size(xtest,1))

        for j=1:size(xtrain,1)
                dot_product=sum((xtest(i,:).* xtrain(j,:)));
                adjacency_matrix_2(1,j)= dot_product / ((sqrt(sum(xtest(i,:).^2))) * (sqrt(sum(xtrain(j,:).^2))));
                adjacency_matrix_2(1,j)= 1 - adjacency_matrix_2(1,j);
        end
        [value,index,e,node_outlier]=max_similarity(adjacency_matrix_2,e,i+size(xtrain,1),tr_value);
        if (value>0)
            adjacency_matrix=[adjacency_matrix;adjacency_matrix_2];
            %adjacency_matrix=[adjacency_matrix;zeros(1,size(adjacency_matrix_2,2))];
            adjacency_matrix_2(1,end+1)=0;
            adjacency_matrix=[adjacency_matrix,adjacency_matrix_2'];
            xtrain=[xtrain;xtest(i,:)];
            %mst=graphminspantree(sparse(adjacency_matrix));
        else
            outlier(1,end+1:end+2)=node_outlier;

        end
    end
       % close(h) 
        len_training_set=size(xtrain,1);
end