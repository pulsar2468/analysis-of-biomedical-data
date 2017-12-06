function [value,index,theta,outlier]=min_distance(euclidean_vector,theta,node,tr_value);
value=0;
index=0;
outlier=0;
%threshold=(median(theta)); % return median value of the weight mst
threshold=theta(floor((size(theta,2)+1)./tr_value)); % median value, median value

         if min(euclidean_vector(euclidean_vector>0)) > threshold
             [value_outlier,index_outlier]=min(euclidean_vector(euclidean_vector>0));            
             outlier=[node,index_outlier];
         else
             [value,index]=min(euclidean_vector(euclidean_vector>0));
             theta(end+1)=value; %% aggiungo il peso nel vettore theta(weights of mst)
             theta=sort(theta);
         end   
end
