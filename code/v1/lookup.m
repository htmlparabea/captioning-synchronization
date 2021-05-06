function t = lookup(audioFilepath, config, table)
%lookup Realiza la estimación del tiempo de inicio para el archivo de audio
%dado.
%   Parámetros de entrada:
%    - audioFilepath: Ruta al archivo de audio.
%    - config: Parámetros de configuración.
%    - table: Tabla de descriptores.
%   Parámetros de salida:
%    - t: Estimación del tiempo de inicio. Si no se puede estimar el tiempo
%         de inicio, la llamada a la función devuelve -1.
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
% Búsqueda de candidatos.
res = searchCandidates(spc, config, table);
% Estimación del tiempo
t = estimateTime(res);

end