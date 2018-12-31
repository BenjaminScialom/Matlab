%task 14

function [ g ] = gfilter(Fs1,Fs2,T)

%Cette fonction permet d'afficher le filtre passe bas gn

[U,D]=rat(Fs1/Fs2);
Lg = 2*T*max(U,D)+1;
s = (Lg-1)/2;
w=hamming(Lg);
n=-s:Lg-s-1;
freqc = min(1/(2*U),1/(2*D));
gperfect = sinc(2*freqc*n);
g = w'.*gperfect;

end

