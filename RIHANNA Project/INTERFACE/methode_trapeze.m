function [X_TPZ, Y_TPZ ] = methode_trapeze( signal,pas,fmin,fmax )
%%  Trapezoid method
%%  INPUT
%   signal : the signal on which we will compute the method
%   pas : the width of each trapezoid
%   fmin,fmax : the frequencies defining the interval of integration
%%  OUTPUT
%   P_trapeze : the area under the trapezoids between fmin and fmax
%%


signal = abs(signal); %in case of a complex signal

n1 = 1:1:length(signal);
N = floor(length(signal)/pas); %the number of trapezoids

x_tpz = []; %the x values of trapezoids
y_tpz = []; %the y values of trapezoids
for i=1:N
    x_tpz = [x_tpz (i-1)*pas+1];
    y_tpz = [y_tpz signal((i-1)*pas+1)];
end

% we now consider the following equation : y = delta*x + b
% we will then compute the values of delta and b for each trapezoid
delta = [];
b = [];
for i=1:N-1
    delta = [ delta (abs(y_tpz(i+1))-abs(y_tpz(i)))/(x_tpz(i+1)-x_tpz(i))];
    b = [b (abs(y_tpz(i))+abs(y_tpz(i+1))-delta(i)*(x_tpz(i)+x_tpz(i+1)))/2];
end


%short = [x_tpz(round(36/pas)) 36];
%droite_test = [abs(y_tpz(round(36/pas))) delta(round(36/pas))*36 + b(round(36/pas))];
% 
% Puissance_Trapeze = 0;
% 
% for i = ceil(fmin/pas):1:round(fmax/pas)
%     Puissance_Trapeze = Puissance_Trapeze + ((abs(y_tpz(i))+abs(y_tpz(i+1)))*pas)/2;
% end
% 
% Puissance_Trapeze = Puissance_Trapeze -(abs(y_tpz(ceil(fmin/pas)))+(delta(ceil(fmin/pas))*fmin + b(ceil(fmin/pas))))/2-(abs(y_tpz(ceil(fmax/pas)))+(delta(ceil(fmax/pas))*fmax + b(ceil(fmax/pas))))/2



X_TPZ = [fmin:0.1:fmax];
delta_plot = zeros(1,length(X_TPZ));
b_plot = zeros(1,length(X_TPZ));

for i =1:length(X_TPZ)
    delta_plot(i) = delta(ceil(X_TPZ(i)/pas));
    b_plot(i) = b(ceil(X_TPZ(i)/pas));
end

Y_TPZ = delta_plot.*X_TPZ + b_plot;

%figure,
%plot(n1,signal);
%hold on;
%plot(x_tpz,abs(y_tpz));
%title('FFT - Methode des trapezes');
%plot(short,droite_test);
%plot(n1,area(X_TPZ,Y_TPZ));
%hold off;

end

