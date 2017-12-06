clear all
close all

load fisheriris
X=meas;

N=size(X,1);
K=3;
%algoritmo partizionale
V=kmeans(X,K,'Distance','correlation')

T=[ones(1,50),2*ones(1,50),3*ones(1,50)]';
G=adiacenza(T);

M=adiacenza(V);

r=length(find(G-M==0))/((N*(N-1))/2)
figure(1);
plot(V,'*');

%algoritmi gerarchici
%trova il dendrogramma usando come input il dataset X
Z = linkage(X,'average','correlation');
U = cluster(Z,'maxclust',K);
figure(2);
plot(U,'*');

M=adiacenza(U);
r=length(find(G-M==0))/((N*(N-1))/2)

