function [ S ] = spectro( X  )
%Spectrogram : modulus squared of the STFT

S=(abs(X).^2);

end

