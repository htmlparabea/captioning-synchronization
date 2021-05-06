function t = sampleToTime(s, fs)
% t = sampleToTime(s, fs)
% Convierte el índice de una muestra de audio a su instante de
% tiempo equivalente.
%
% Parámetros de entrada:
%  - s: Índice de la muestra de audio.
%  - fs: Frecuencia de muestreo.
%
% Parámetros de salida:
%  - t: Instante de tiempo equivalente de acuerdo con la frecuencia de
%    muestreo.
% -------------------------------------------------------------------------

t = (s - 1) / fs;

end