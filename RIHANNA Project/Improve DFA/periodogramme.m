function [ periodogramme_simple ] = periodogramme( signal,pas )
%%  Simple periodogramm function
%   This function computes the 'simple' version of a periodogramm for a 
%   signal. It is based on a sliding window computing the mean around each
%   value of the signal.

%%  INPUT
%   signal
%   pas : size of the sliding window

%%  OUTPUT
%   periodogramme_simple : the values computed. (the vector will contain
%   length(signal)-1 columns with only 0s, only the first row is relevant. 

%%  First steps

T = length(signal);

periodogramme_simple=zeros(length(signal));
g=zeros(ceil(pas/2)); % the left side of the window (centered on a value)
d=zeros(ceil(pas/2)); % the right side of the window

for i = 1:length(signal)
    if (i-pas/2)<1 % We sum the left side of the window, 'looping' with the
%end of the signal if necessary.
        g = mean(signal(length(signal)-pas/2+i:length(signal))) + mean(signal(1:i));
    else
        g = mean(signal(i-pas/2:i));
    end
    
    if (i+pas/2)>length(signal) %same thing goes for the right side.
        d = mean(signal(i:length(signal))) + mean(signal(1:pas/2-(length(signal)-i)));
    else
        d = mean(signal(i:i+pas/2));
    end
    
    periodogramme_simple(i) = mean(d+g); %we then sum everything up and
    %computes the mean.
end


periodogramme_simple = periodogramme_simple(:,1);

% figure,
% plot(f,sp,'cyan');
% title('Periodogramme "simple"');
% xlabel('f');
% ylabel('|Signal|^2/longueur du signal');
% hold on;
% plot(f,periodogramme_simple(:,1))

end
