clear all
close all

%numero di punti totali
N=1000;
%estremi superiore ed inferiore delle x
ax=-5;
bx=10;

%epsilon definisce il margine (in input)
eps = 0.5;
%parametri della retta r
m=-3;
q=2;

%xy sono coordinate di punti generati in modo random sull'intervallo [a b] 
%xy=zeros(2,N);
xy(1,:)=((bx-ax)*rand(1,N)+ax);


%q1 e q2 sono i q di due rette considernado il margine eps 
q1=q+eps;
q2=q-eps;

figure(1);

%grafico delle rette r1: mx+q1, r2: mx+q2
hold on
yas=m*ax+q1;
yai=m*ax+q2;

ybs=m*bx+q1;
ybi=m*bx+q2;

line([ax,bx],[yas,ybs],'LineStyle','--','Color','red');
line([ax,bx],[yai,ybi]','LineStyle','--','Color','red');
%plot(x,ys,'--red');
%plot(x,yi,'--red');

ay=min([yas,yai,ybs,ybi]);
by=max([yas,yai,ybs,ybi]);

xy(2,:)=((by-ay)*rand(1,N)+ay);

%seleziona i punti che stanno sopra la retta r1
I=find(xy(2,:)-m*xy(1,:)-q1>0);

%seleziona i punti che stanno soto la retta r2
II=find(xy(2,:)-m*xy(1,:)-q2<0);

%numero di punti che stanno sopra la retta r1
n1=length(I);

%numero di punti che stanno soto la retta r2
n2=length(II);

%considero realmente n punti, praticamente ho eliminato tutti quelli che
%stanno nella zona al di sotto di r1 e sopra r2
n=n1+n2;

%creo il dataset X di punti che stanno nella zona al di sopra di r1 e sotto r2 
X=[xy(:,I) xy(:,II)];
t=zeros(1,n);

%assegno le etichette
t(1:n1)=1;
t(n1+1:n)=0;



%applico l'algoritmo del percettrone
net = newp([ax bx; ay by],1);
%net = train(net,xy,t);
passes=100;
%xyz=con2seq(xy);
%tp=con2seq(t);

[xtrain,xtest,nt]=setsplit(X',t',0.7)

X=cell2mat(xtrain')';
l=unique(t);
t=[];

%visualizzo i punti di training
plot(X(1,1:nt(1)),X(2,1:nt(1)),'*');
plot(X(1,nt(1)+1:end),X(2,nt(1)+1:end),'+');

for i=1:length(nt)
 t=[t repmat(l(i),[1,nt(i)])]; 
end

for i=1:passes
 net=adapt(net,X,t);
end

w=net.IW{1,1};
b=net.b{1};

%trovo m1 e q1 della retta di separazione
m1= -w(1)/w(2);
q1= -b/w(2);

%visualizzo la retta di separazione
x=ax:0.001:bx;
plot(x,m1*x+q1,'green');

X=cell2mat(xtest')';
t=[];

nt= [n2,n1]-nt

for i=1:length(nt)
 t=[t repmat(l(i),[1,nt(i)])]; 
end

%visualizzo i punti di test
plot(X(1,1:nt(1)),X(2,1:nt(1)),'g*');
plot(X(1,nt(1)+1:end),X(2,nt(1)+1:end),'g+');

y=sim(net,X);
acc=length(find(y==t))./length(t)