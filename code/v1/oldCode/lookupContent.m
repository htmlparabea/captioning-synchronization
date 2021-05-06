function perf = lookupContent(audioFilepath, srtFilepath, config, table)
%lookupContent Realiza la estimación de los tiempos para los fragmentos de
%audio de entrada.
%   Parámetros de entrada:
%    - audioFilepath: Ruta al archivo de audio.
%    - srtFilepath: Ruta al archivo SRT de fragmentos.
%    - config: Parámetros de configuración.
%    - table: Tabla de descriptores.
%   Parámetros de salida:
%    - perf: Vector (2x1) que contiene las prestaciones de la estimación.
%         perf(1): Número de elementos procesados.
%         perf(2): Porcentaje de fragmentos para los que se ha dado
%         estimación.
%         perf(3): Error cuadrático medio de los tiempos estimados.
% 
% Almacenar  en un SRT los fragmentos de prueba. P.ej;
% 1                                 Número de fragmento
% 00:00:04,750 --> 00:00:07,625     Marcas de tiempo en el archivo de test
% 1231,433                          Instante de tiempo a estimar.
%
% 1. Abrir el archivo SRT.
% 2. Abrir el archivo de audio.
% 3. Para cada fragmento definido en el SRT.
%   1. Extraer el fragmento de audio.
%   2. Generar los descriptores.
%   3. Recuperar descriptores (lookup) de la tabla.
%   4. Estimar instante de tiempo.

fprintf('Looking up for content...\n');

%% Lectura de los archivos de audio y de subtítulos.
audio = readAudio(audioFilepath);
fragments = readSrt(srtFilepath);

%% Inicialización de variables
K = length(fragments);
times = zeros(K, 1);

%% Indexado de subtítulos
for k = 1 : K 
    
    frg = fragments(k);   
    % Obtención del fragmento de audio correspondiente al subtítulo
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
    %times(k) = estimateTime2(res);
    % Estimación del tiempo. (Versión previa)
    times(k) = estimateTime(res);
    
    % Se tiene la información tiempo-frecuencia de: 1) los descriptores
    % extraídos del fragmento y 2) los descriptores recuperados del lookup.
    % Los descriptores recuperados están desplazados al tiempo y frecuencia
    % de referencia. Por lo tanto, hay que encontrar los valores de tiempo
    % y frecuencia que hacen mínima la distancia entre ambos conjuntos.
    % Hay que hacer que ambos conjuntos posean el mismo número de elementos
    % y para cada elemento hay que encontrar su equivalente más cercano 
    % en el otro grupo.
    
end

%% Estimación del error...

found    = 0;
cumError = 0;

for k = 1 : K
    
    frg = fragments(k);
    t = times(k);
    
    if t > 0
        fprintf('Found: %g --> %g \n', [frg.Start; t]);
        found = found + 1;       
        cumError = cumError + ((t - frg.Start) ^ 2);
    else
        fprintf('Not found\n');
    end
    
end

error = sqrt(cumError) / found;

fprintf('\n');
fprintf('Performance\n');
fprintf('Total : %d\n', K);
fprintf('Found : %f\n', found/K);
fprintf('Error : %g\n', error);

perf(1) = K;
perf(2) = found/K;
perf(3) = error;

end