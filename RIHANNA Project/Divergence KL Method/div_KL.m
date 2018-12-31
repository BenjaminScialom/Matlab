<<<<<<< Updated upstream
function [KL]=div_KL( signal_1,signal_2)

%les 2 signaux doivent avoir le meme nombre de valeurs differentes.
% la divergence de KL mesure la similarité de la repartition des
% differentes valeurs des deux signaux consideres.



% signal_1=[ 1 2 3 4 3 3 3]
% signal_2=[6 7 8 9 8 8 8 ]


l_unique_1=length(unique(signal_1));
l_unique_2=length(unique(signal_2));

count_1=hist(signal_1,l_unique_1);
count_2=hist(signal_2,l_unique_2);

count_1=count_1/length(signal_1);
count_2=count_2/length(signal_2);


KL_temp=log(count_1./count_2).*count_1;
KL=sum(KL_temp);


end





=======
function [KL]=div_KL( signal_1,signal_2)

%les 2 signaux doivent avoir le meme nombre de valeurs differentes.
% la divergence de KL mesure la similarité de la repartition des
% differentes valeurs des deux signaux consideres.



% signal_1=[ 1 2 3 4 3 3 3]
% signal_2=[6 7 8 9 8 8 8 ]


l_unique_1=length(unique(signal_1));
l_unique_2=length(unique(signal_2));

count_1=hist(signal_1,l_unique_1);
count_2=hist(signal_2,l_unique_2);

count_1=count_1/length(signal_1);
count_2=count_2/length(signal_2);


KL_temp=log(count_1./count_2).*count_1;
KL=sum(KL_temp);


end





>>>>>>> Stashed changes
