function output = fragmentAudio(input, frg)
% output = fragmentAudio(input, frg)
% Obtiene el audio correspondiente al fragmento dado.
%
% Parámetros de entrada:
%  - input: Objeto audio que contiene los datos de audio originales.
%  - frg: Fragmento que marca el inicio y el final.
%
% Parámetros de salida:
%  - output: Objeto audio que contiene los datos de audio recortados.
% -------------------------------------------------------------------------

startSample = timeToSample(frg.Start, input.Fs);
endSample   = timeToSample(frg.End, input.Fs) - 1;

L = startSample + (endSample - startSample);

if L <= length(input.Data)
    y = input.Data(startSample:endSample);
else
    y = input.Data(startSample:end); 
end

output = Audio(y, input.Fs);

end