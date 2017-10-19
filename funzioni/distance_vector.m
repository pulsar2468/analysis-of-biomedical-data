function adjacency_matrix=distance_vector(xtrain);
    adjacency_matrix=zeros(size(xtrain,1),size(xtrain,1));
    for i=1:size(xtrain,1)
        for j=i+1:size(xtrain,1)
                adjacency_matrix(i,j)=sqrt(sum((xtrain(i,:) - xtrain(j,:)).^2)); %calcolo la distanza euclidea
                adjacency_matrix(j,i)=adjacency_matrix(i,j);
            end
            
        end
end