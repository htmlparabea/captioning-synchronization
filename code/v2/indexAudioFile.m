function index = indexAudioFile(filePath, config)
% table = indexAudioFile(filepath, config)
% Realiza el indexado completo del archivo de audio especificado.
%
% Parámetros de entrada:
%  - filepath: Ruta al archivo de audio.
%  - config: Parámetros de configuración.
%
% Parámetros de salida:
%  - index: Tablas hash que contiene los descriptores indexados.
% -------------------------------------------------------------------------

fprintf('Indexing audio file...\n');
fprintf('  File: %s.\n', filePath);


%% Lectura del archivo de audio
audio = readAudio(filePath);

%% Indexado del contenido
startTime = cputime;

index = indexAudio(audio, config);

totalTime = cputime - startTime;
info = whos('index');

fprintf('Indexing adio file: OK!\n');
fprintf('Time to index: %f seconds.\n', totalTime);
fprintf('Size of index: %f MB.\n', info.bytes / (1024*1024));
fprintf('\n');

end