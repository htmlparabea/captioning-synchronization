function frgs = getFragments(duration, config)
% frgs = getFragments(duration, config)
% Obtiene el listado de fragmentos en los que se divide el archivo de
% audio.
%
% Parámetros de entrada:
%  - duration: Duración en segundos del archivo de audio.
%  - config: Parámetros de configuración.
%
% Parámetros de salida:
%  - frgs: Array que contiene el listado de fragmentos en los que se
%    divide el archivo de audio.
% -------------------------------------------------------------------------

K = floor(duration / config.IndexLength);
frgs(K, 1) = Fragment();

for k = 1 : K
    
    frg = Fragment(k);
    frg.Start = (k-1) * config.IndexLength;
    frg.End = k * config.IndexLength;
    frgs(k) = frg;
    
end