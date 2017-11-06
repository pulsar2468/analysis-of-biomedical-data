function adjacency_matrix=cosine_similarity(xtrain);
    adjacency_matrix=zeros(size(xtrain,1),size(xtrain,1));
    for i=1:size(xtrain,1)
        for j=i+1:size(xtrain,1)
                dot_product=sum((xtrain(i,:).* xtrain(j,:)));
                adjacency_matrix(i,j)= dot_product / (sqrt(sum((xtrain(i,:).^2))) * sqrt(sum((xtrain(j,:).^2))));
                adjacency_matrix(j,i)=adjacency_matrix(i,j);
            end
            
    end
end