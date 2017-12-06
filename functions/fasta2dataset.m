%converte il fasta file di n sequenze nel dataset D rappresentato secondo k-meri
%D ha n righe, 4^K colonne + 1 per la classe di appartenenza

function [ D ] = fasta2dataset( input_file,taxonomy_file,K )
 load(taxonomy_file);
   
 %fasta file con le sequenze
 [H, S] = fastaread(input_file);
  
 %id di ogni sequenza
 idseq=taxonomy(2:end,1);

 %costruiamo la matrice che memorizza le label di appartenenza per ogni tassonomia
 classes = zeros(size(taxonomy,1)-1,size(taxonomy,2)-1);
 %le label di appartenenza vengono trasformate in etichette numeriche 
 for i=1:size(taxonomy,2)-1
  St=unique(taxonomy(2:end,i+1));
  for j=1:length(idseq)
   [a,ind]=ismember(taxonomy{j+1,i+1},St);
   classes(j,i)=ind; 
  end
 end

 %viene creato il dataset myD che ha length(H) righe e 4^k +
 %size(taxonomy,2)-1 colonne, ovvero dopo ogni rappresentazione a k-meri
 %della sequenza vengono aggiunte le etichette di classe per ogni
 %tassonomia
 msg = ['Please wait generattion of ', num2str(K),'mers'];
 h = waitbar(0,msg);
 
 myD=zeros(length(H), 4^K+size(taxonomy,2)-1);
 for i=1:length(H)
  s=H{i};
  b=min(find(s==' '));
  %id della sequenza
  idseqcp=s(1:b-1);
  %t è la sequenza
  t=S{i};

  for j=1:length(t)-K+1
   kmer=t(j:j+K-1);
   in=kmer2index(kmer);
   myD(i,in)=myD(i,in)+1; 
  end
     
  [~,iq]=ismember(idseqcp,idseq);
  myD(i,1:4^K)=myD(i,1:4^K)./sum(myD(i,1:4^K));
  myD(i,4^K+1:end)=classes(iq,:);  
  
  waitbar(i / length(H))
  
 end
 %Riassegnazione labels e scrittura file per ogni tassonomia
 for i=1:size(taxonomy,2)-1
  D=myD(:,1:end-size(taxonomy,2)+1);
  D=[D,myD(:,size(D,2)+i)];
  c=D(:,end);
  l=unique(c);
  lb=intersect(l,1:1:max(c));
  vc=zeros(1,length(l));
  vc(lb)=1:1:length(l);
  d=vc(c);
  D(:,end)=vc(c);
  iz=find(input_file=='.');
  output_file='';
  output_file=[input_file(1:iz-1) '_' num2str(K) '_' taxonomy{1,i+1} '.mat']
  save(output_file,'D');
 end
 close(h)
end

