function [SampEn]=Sec2(cg_signal,m,r)
 
 
ratio_m = 0;
ratio_mm = 0;
 
 
 
for i=1: length(cg_signal)-m+1
   
    temp_m=cg_signal(i:i+m-1);
    
    for j=1:length(cg_signal)-m+1
       
        if abs(cg_signal(j:j+m-1)-temp_m)<= r
                ratio_m=ratio_m+1;
        end
    end
    ratio_m=ratio_m-1;
end
 
 
 
 
for i=1: length(cg_signal)-m
   
    temp_mm=cg_signal(i:i+m);
    
    for j=1:length(cg_signal)-m
       
        if abs(cg_signal(j:j+m)-temp_mm)<= r
                ratio_mm=ratio_mm+1;
        end
    end
    ratio_mm=ratio_mm-1;
end
 
 
 
ratio_m;
ratio_mm;
SampEn=log(ratio_m/ratio_mm);
 
end

