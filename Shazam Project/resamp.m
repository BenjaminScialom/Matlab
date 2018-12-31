function [ r ] = resamp( query,Fs1,Fs2 )
%fonction qui adapte le signal

F = Fs1/Fs2;
[U,D] = rat(F)
r = upsample(query,U);
g = gfilter(Fs1,Fs2,10);
r = conv(r,g);
r = downsample(r,D);

end

