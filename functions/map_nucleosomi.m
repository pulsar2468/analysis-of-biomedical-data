function [Y,targets]=map_nucleosomi(namefile);
path = '/home/nataraja/Scrivania/analysis-of-biomedical-data/Dataset/';

filename = [path,'/',namefile];

S=fastaread(filename);

X=cell(2,1);

X{1}='';
X{2}='';

for i=1:length(S)
    h=S(i).Header;
    if(h(1)=='N')
     X{1}(end+1,:)=S(i).Sequence;
    else
     X{2}(end+1,:)=S(i).Sequence;
    end
end

K=2;

msg = ['Please wait generation of ', num2str(K),'mers'];
h = waitbar(0,msg);

Y=zeros(length(X{1})+length(X{2}),4^K);
targets = zeros(length(X{1})+length(X{2}),1);

for i=1:length(X)
 for j=1:length(X{i})   
  t=X{i}(j,:);
  v=zeros(1,4^K);
  for k=1:length(t)-K+1
   kmer=t(k:k+K-1);
   in=kmer2index(kmer);
   v(in)=v(in)+1; 
  end
  targets(((i-1)*length(X{1}))+j,1)=i;
  Y(((i-1)*length(X{1}))+j,:)=v./sum(v);
  waitbar(((i-1)*length(X{1}))+j / (length(X{1})+length(X{2})))
 end
end
close(h);

%10 fold cross validation

%c = cvpartition(targets,'KFold',10)
% 
% %sensitivit� e specificit�
% Se=zeros(1,c.NumTestSets);
% Sp=zeros(1,c.NumTestSets);
% 
% for i=1:c.NumTestSets
% 
%  trIdx = c.training(i);
%  teIdx = c.test(i);    
%    
%  svmStruct=svmtrain(Y(trIdx,:),targets(trIdx),'kernel_function','rbf')
%  group = svmclassify(svmStruct,Y(teIdx,:));
%  
%  C = confusionmat(group,targets(teIdx));
%  S=sum(C');
%  
%  rC(1,:)=C(1,:)./S(1);
%  rC(2,:)=C(2,:)./S(2);
%  
%  Se(i)=rC(1,1);
%  Sp(i)=rC(2,2);
% end
% 
% mean(Se)
% mean(Sp)