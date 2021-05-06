function table = indexAudioFile(filePath, config)
% table = indexAudioFile(filepath, config)
% Realiza el indexado completo del archivo de audio especificado.
%
% Parámetros de entrada:
%  - filepath: Ruta al archivo de audio.
%  - config: Parámetros de configuración.
%
% Parámetros de salida:
%  - table: Tabla hash que contiene los descriptores indexados.
% -------------------------------------------------------------------------

fprintf('Indexing audio file...\n');
fprintf('  File: %s.\n', filePath);

%% Lectura del archivo de audio
audio = readAudio(filePath);

%% Indexado del contenido
table = indexAudio(audio, config);

fprintf('Indexing adio file: OK!\n');

end