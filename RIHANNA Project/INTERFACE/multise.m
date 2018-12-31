
function [Area,SampEn]=multise(original_signal,max_scale,m,r)

%il ya une contrainte par rapport au choix de max_scale car au dela d'une
%taille minimale sampen est egale a INF
SampEn=zeros(1,max_scale);
for i=1:max_scale
    [cg_signal,original_signal_adapted]=coarse_grain(original_signal,i);
    SampEn(i)=Sec2(cg_signal,m,r);
    Area=trapz(1:max_scale,SampEn);
end



end


