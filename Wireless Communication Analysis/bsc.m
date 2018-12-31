function [ y ] = bsc(c, p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y=c;
for i=1:length(c)
    if(rand < p)
        y(i)=~c(i);
    end
end
        

end

