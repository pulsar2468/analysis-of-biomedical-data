clear all 
close all

taxonomy_file='taxonomy.mat';
input_file='16S.fas';
load(taxonomy_file);
taxonomies = taxonomy(1,:);

kmin=2;
kmax=2;

for j=kmin:kmax
 fasta2dataset(input_file,taxonomy_file,j);
end

