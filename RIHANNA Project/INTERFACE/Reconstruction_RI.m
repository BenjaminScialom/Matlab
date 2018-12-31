function [ signal ] = Reconstruction_RI(M)


%%%%%%%%INPUTS :
%            - Overlap: percentage (minimum) will be written : ex 10% --> 0.1
%            - Matrix where ligns are corresponding to the different frames
%%%%%%%%OUTPUTS : 
%            - Original signal from the matrix

[ligne,colonne]=size(M);
signal=zeros(1,ligne*colonne);
debut=1;

for kk=1:ligne
   signal(1,debut:debut+colonne-1)=M(kk,:);
   debut=debut+colonne;
end

end

