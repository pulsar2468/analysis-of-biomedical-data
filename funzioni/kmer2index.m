function [i] = kmer2index(ikmer)
 K=length(ikmer);
 kmer=upper(ikmer);
 %mask è un vettore per la traduzione di identificativo di nucleotida in numero 
 mask=zeros(1,26);
 %A
 mask(1)=1;
 %C
 mask(3)=2;
 %G
 mask(7)=3;
 %T
 mask(20)=4;

 %'b' -> g or c or t
 d=[2,3,4];
 mask(2)=d(randi([1,3]));
 %'d' -> a or g or t
 d=[1,3,4];
 mask(4)=d(randi([1,3]));
 %'h' -> a or c or t
 d=[1,2,4];
 mask(8)=d(randi([1,3]));
 %'k' -> g or t
 mask(11)=randi([3,4]);
 %'m' -> a or c
 mask(13)=randi([1,2]);
 %'n' -> any nucleotide
 mask(14)=randi([1,4]);
 %'r' -> a or g
 d=[1,3];
 mask(18)=d(randi([1,2]));
 %'s' -> c or g
 mask(19)=randi([2,3]);
 %'v' -> a or g or c
 d=[1,2,3];
 mask(22)=d(randi([1,3]));
 %'w' -> a or t
 d=[1,4];
 mask(23)=d(randi([1,2]));
 %'y' -> c or t
 d=[2,4];
 mask(25)=d(randi([1,2]));

 x=double(kmer)-ones(1,length(kmer))*65+1;
 y=mask(x);
 jk=1:K;
 z=4.^(K-jk);
 i=z*(y-1)'+1;

end

