
function [ D2 ] = aligndist( ZI,ZJ )
 m2=length(ZJ);
 D2=zeros(m2,1);
 for i=1:m2
  s12=nwalign(ZI,ZJ(i,:));
  s11=nwalign(ZI,ZI);
  s22=nwalign(ZJ(i,:),ZJ(i,:));
  D2(i)=(1-s12/s11)*(1-s12/s22);
 end

%custom distance function — A distance function specified using 
%@ (for example, @distfun). A custom distance function must
%Have the form function D2 = distfun(ZI, ZJ)
%Take as arguments:
%A 1-by-n vector ZI containing a single row from X or from the
%query points Y
%An m2-by-n matrix ZJ containing multiple rows of X or Y
%Return an m2-by-1 vector of distances D2, whose jth element 
%is the distance between the observations ZI and ZJ(j,:)

end