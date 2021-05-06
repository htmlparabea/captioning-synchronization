function [table, spcs] = indexContent(audioFilepath, srtFilepath, config)
%indexContent Realiza el indexado de los subtítulos de un archivo de audio
%dado.
%   Ofrece mecanismos para indexar el contenido de un archivo de audio.
%   Parámetros de entrada:
%    - audioFilepath: Ruta al archivo de audio.
%    - srtFilepath: Ruta al archivo de subtítulos.
%    - config: Parámetros de configuración.
%   Parámetros de salida:
%    - table: Tabla hash que contiene los descriptores indexados.
%    - spcs: Espectrogramas.

fprintf('Indexing content...\n');

%% Lectura de los archivos de audio y de subtítulos.
audio = readAudio(audioFilepath);
fragments = readSrt(srtFilepath);

%% Inicialización de variables
table = Table(config);
K = length(fragments);
spcs(K,1) = Spectrogram();

%% Indexado de subtítulos
for k = 1 : K 
    fprintf('Indexing item %d / %d \n', [k; K]);
    
    frg = fragments(k);   
    % Obtención del fragmento de audio correspondiente al subtítulo
    aud = getAudio(audio, frg);
    % Cálculo del espectrograma del fragmento.
    spc = computeSpectrogram(aud, config);
    spc.Times = spc.Times + frg.Start;
    % Cuantificación del espectrograma.
    spc = quantizeSpectrogram(spc, config);
    % Conversión de la escala lineal por una logarítmica.
    spc = scaleSpectrogram(spc, config);
    % Cálculo de la SIFT del espectrograma.
    spc = computeDescriptors(spc, config);
    % Indexado de los descriptores.
    table = indexSpectrogram(spc, table);
    
    spcs(k) = spc;    
end

table.trim();

fprintf('Indexing content: OK!\n');
fprintf('Indexed: %d descriptors\n\n', table.Count);

end