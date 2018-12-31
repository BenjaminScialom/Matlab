function [ D_s, A_s ] = Cut_number(signal,xabsis,Nombre )
%%    this function cuts the signal into a predestinated number of pieces
%%INPUT : signal: signal given
%%        xabsis : absis given 
%%        Nombre : number which the signal need to be cut into
%%OUTPUT:  D_s= matrix which lines are the different trame of the signal
%%         A_s= matrix which lines are the different trame of the absis

%L: Total length of the signal 
L=length(signal);
% Compute of lenth of new window
window= 2*Nombre+1;

%% Declaration of variable: 
%N_rec : mutual numbers in frames
N_rec=Nombre+1;
%N_line: number of line to create with that cut
N_line=floor((L-N_rec)/(window-N_rec));

% Matrix creation 
D_s=zeros(N_line,window);

%%Filling the matrix
start_filling=1;
end_filling=window;

for k=1:N_line % For each line, it saves the datas into D_s matrix with an n+1 overlap
    D_s(k,:)=signal(1,(start_filling):(end_filling));
    A_s(k,:)=xabsis(1,(start_filling):(end_filling));
    start_filling=end_filling-Nombre;
    end_filling=start_filling+window-1;
end

end

