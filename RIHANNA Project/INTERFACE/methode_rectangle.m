function [X,Y ] = methode_rectangle( signal,pas,fmin,fmax )
%%  Rectangle method
%%  INPUT
%   signal : the signal on which we will compute the method
%   pas : the width of each rectangle
%   fmin,fmax : the frequencies defining the interval of integration
%%  OUTPUT
%   P_rectangle : the area under the rectangles between fmin and fmax
%%

signal = abs(signal); %in case the signal is complex
%n1 = -0.5:0.001:0.5;
n1 = 1:1:length(signal); 

N = length(signal)/pas; %the number of rectangles we will compute

zr=zeros(length(signal),1);
x=1;

for i=1:N
    temp1=signal(x); %we set the left side value of the rectangle
    temp2=signal(x+pas-1); %we then set the right side value
    if (temp1<temp2)
        zr(x:x+pas-1)=temp1; %we affect the lowest value to each point
    else
        zr(x:x+pas-1)=temp2;
    end
    x=x+pas; %skip to the next rectangle
end


%figure,
%plot(n1,signal);
%hold on;
%plot(n1,abs(zr));
%hold on;
%% Puissance sur un intervalle de frequences



%The main idea here is to compute the area under the rectangles between 
%fmin and fmax. We first compute the area of the 'whole' rectangles, before
%computing the remaining smaller parts.

% for i=floor(fmin):1:floor(fmax)+1
%     P_rectangle = P_rectangle + abs(zr(i)); %We take the 'whole' part first
% end

% P_rectangle = P_rectangle - (fmin-floor(fmin))*abs(zr(floor(fmin))) - (floor(fmax)+1-fmax)*abs(zr(floor(fmax)))
%we then compute the smaller remaining areas on the left and right side


X = fmin:0.2:fmax;
Y = abs(zr(floor(X)))

%plot(n1,area(X,Y));
%title('Rectangular method');
%legend('Puissance',P_rectangle);
%hold off;

end

