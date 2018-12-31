function [SampEn]=SampEn_computing(cg_signal,r)

%cette fonction permet de calculer la sample entropy pour un signal en
%grain-crossier obtenu grace a la fonction implementé avant
%rem: la valeur de r peut etre choisi en 10% ... peut etre display
% cg_signal= 75 + (85-75).*rand(40,1) test


m=2;
% choix m et r mais pas obligatoire

%doc: then repeated for all other possible template sequences 


ratio_2=0;%%remplacer apres par m et mm si m est choisie
ratio_3=0;



for i=1: length(cg_signal)-1
   
    temp_m=[cg_signal(i) cg_signal(i+1)];

    
    interval_cg_m_1=cg_signal(1:i-1);
    interval_cg_m_2=cg_signal(i+2:end);

    
    
    l_m_1=length(interval_cg_m_1);
    l_m_2=length(interval_cg_m_2);


if l_m_1 >= m
    for j=1:l_m_1-1
        if abs(interval_cg_m_1(j)-temp_m(1))<=r && abs(interval_cg_m_1(j+1)-temp_m(2))<=r
            ratio_2=ratio_2+1;
%             find(cg_signal == interval_cg_m_1(j))
%             indice=i le debut du motif considéré
        end
    end
end


if l_m_2 >= m
    for k=1:l_m_2-1
        if abs(interval_cg_m_2(k)-temp_m(1))<=r && abs(interval_cg_m_2(k+1)-temp_m(2))<=r
            ratio_2=ratio_2+1;
%             find(cg_signal == interval_cg_m_2(k))
%             indice=i
            
        end
    end
end
end
 






for i=1: length(cg_signal)-2
   
    
    temp_mm=[cg_signal(i) cg_signal(i+1) cg_signal(i+2)];
    
    
    interval_cg_mm_1=cg_signal(1:i-2);
    interval_cg_mm_2=cg_signal(i+2:end);
    
    l_mm_1=length(interval_cg_mm_1);
    l_mm_2=length(interval_cg_mm_2);

if l_mm_1 >= m+1
    for j=1:l_mm_1-2
        if abs(interval_cg_mm_1(j)-temp_mm(1))<=r && abs(interval_cg_mm_1(j+1)-temp_mm(2))<=r && abs(interval_cg_mm_1(j+2)-temp_mm(3))<=r
            ratio_3=ratio_3+1;
%             find(cg_signal == interval_cg_mm_1(j));%debut du motif qui match
%             indice=i ;%le debut du motif considéré
        end
    end
end


if l_mm_2 >= m+1
    for k=1:l_mm_2-2
        if abs(interval_cg_mm_2(k)-temp_mm(1))<=r && abs(interval_cg_mm_2(k+1)-temp_mm(2))<=r && abs(interval_cg_mm_2(k+2)-temp_mm(3))<=r
            ratio_3=ratio_3+1;
%             find(cg_signal == interval_cg_mm_2(k));
%             indice=i;
            
        end
    end
end

end


SampEn=log(ratio_2/ratio_3);
















end





    
    
    
    
    
    
    





