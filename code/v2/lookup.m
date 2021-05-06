function [t, ti, s] = lookup(audioFilepath, config, index, t0, ti0)
%lookup Realiza la estimación del tiempo de inicio para el archivo de audio
%dado.
%   Parámetros de entrada:
%    - audioFilepath: Ruta al archivo de audio.
%    - config: Parámetros de configuración.
%    - index: Tablas hash de descriptores.
%    - t0: Último tiempo estimado conocido.
%    - ti0: Tiempo desde el que se realiza la búsqueda.
%   Parámetros de salida:
%    - t: Estimación del tiempo de inicio.
%    - ti: Tiempo desde donde se ha de iniciar la búsqueda en la siguiente
%         llamda.
%    - s: Número de descriptores utilizados en la estimación. Si s = 0, no
%         se ha encontrado el fragmento.
% 

audio = readAudio(audioFilepath);
fragments = audio.getFragments(config.LookupLength);
frg = fragments(1);

% Fragmentado del archivo.
aud = fragmentAudio(audio, frg);
% Cálculo del espectrograma del fragmento.
spc = computeSpectrogram(aud, config);
% Cuantificación del espectrograma.
spc = quantizeSpectrogram(spc, config);
% Conversión de la escala lineal por una logarítmica.
spc = scaleSpectrogram(spc, config);
% Cálculo de la SIFT del espectrograma.
spc = computeDescriptors(spc, config);
% Determinación de las tablas para realizar la búsqueda.
idxs = findTables(index, ti0);
 
if t0 < -10
    t = 0;
else
    t = t0 + audio.getDuration();
end

% Número de descriptores utilizados...
s = 0;
% Número mínimo de descriptores para alinear...
tmp = 2 + (0.5 * audio.getDuration());

I = length(idxs);

for i = 1 : I
    idx = idxs(i);
    table = index{idx};
    
    % Búsqueda de candidatos.
    res = searchCandidates(spc, config, table);
    if length(res) > tmp 
       tmp = length(res);
        % Estimación del tiempo
        t = estimateTime(res); 
        s = length(res);
    end
end

% Actualización del nuevo tiempo de búsqueda...
dif = t - (t0 + audio.getDuration());

if dif > 1.5 * audio.getDuration()
    % No se actualiza el tiempo de búsqueda...
    ti = ti0;
else
    ti = t;    
end

end