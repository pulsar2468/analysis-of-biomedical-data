function tmp_list=my_kruskal(adjacency_list);

node_visited=[];
edge_label=nchoosek(1:size(adjacency_list,2),2) % rappresenta le disposizioni semplici senza ripetizione (etichette lista per kruskal)
tmp_list=cell(1,size(edge_label,1));
for i=1:size(adjacency_list,2)
    node=edge_label(i,:);
    tmp_list{i}={node,adjacency_list{node(1)}(node(2))};
end

end