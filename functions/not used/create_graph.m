function create_graph(x) % x=graph
n = 10;
A = delsq(numgrid('L',n+2));
G = graph(A,'OmitSelfLoops')
plot(G)

end
% G=graph
% for i=1:lenght(x)
%     G=addnode(G,i)
% end
% 
% for i=1:lenght(x)
%     G=addedge(G,i,x{i}(1))
% end
% plot(G)