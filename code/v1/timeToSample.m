function s = timeToSample(t, fs)
% s = timeToSample(t, fs)
% Convierte un instante de tiempo a su muestra equivalente.
%
% Parámetros de entrada:
%  - t: Instante de tiempo en segundos.
%  - fs: Frecuencia de muestreo.
%
% Parámetros de salida:
%  - s: Índice de la muestra equivalente según la frecuencia de muestreo.
% -------------------------------------------------------------------------

s = 1 + floor(t * fs);

end