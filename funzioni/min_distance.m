function [value,index,theta,outlier]=min_distance(euclidean_vector,theta,node,perc_threshold);
value=0;
index=0;
outlier=0;
tmp_max=max(theta);
threshold=tmp_max*perc_threshold/100;

         if min(euclidean_vector(euclidean_vector>0)) > mean(theta)%threshold
             [value_outlier,index_outlier]=min(euclidean_vector(euclidean_vector>0));            
             outlier=[node,index_outlier];
         else
             [value,index]=min(euclidean_vector(euclidean_vector>0));
             theta(end+1)=value; %% aggiungo il peso nel vettore theta(weights of mst)
         end   
end
