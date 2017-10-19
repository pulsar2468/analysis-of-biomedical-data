SIGMA = [double('A'),double('C'),double('G'),double('T')]
L=10;
N=100;
S='';

for i=1:N
 J=randi([1,4],1,L);
 S(i,:)=char(SIGMA(J));   
end

D=aligndist(S(1,:),S);
[I,D]=knnsearch(S,S(1,:),'K',10,'Distance',@aligndist)

S(I,:)

