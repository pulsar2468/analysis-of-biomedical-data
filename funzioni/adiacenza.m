function [ M ] = adiacenza( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N=size(I,1);
offset = 0;

M=zeros((N*(N-1))/2,1);

for i=1:N-1
  v=I(i+1:N);
  M(offset+1:offset+N-i)=(v==I(i));
  offset=offset+N-i;
end

end

