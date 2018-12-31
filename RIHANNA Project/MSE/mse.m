
function [SampEn]=mse(original_signal,max_scale,m,r)

%il ya une contrainte par rapport au choix de max_scale car au dela d'une
%taille minimale sampen est egale a INF
SampEn=zeros(1,max_scale);
for i=1:max_scale
    [cg_signal,original_signal_adapted]=coarse_grain(original_signal,i);
    SampEn(i)=Sec2(cg_signal,m,r);
end
%0.15*std(original_signal)
figure
plot(SampEn)
%  ylim([1.4 2.6]);
xlabel('scale')
ylabel('SampEn')

end


