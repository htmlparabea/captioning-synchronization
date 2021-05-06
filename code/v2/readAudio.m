function audio = readAudio(filePath)
% audio = readAudio(filePath)
% Abre el archivo de audio y lee su contenido. Si el archivo es estéro,
% realiza la mezcla de los dos canales y devuelve una versión mono del
% audio.
%
% Parámetros de entrada:
%  - filePath: Ruta absoluta al archivo de audio cuyo contenido se 
%    recupera.
% Parámetros de salida:
%  - audio: Objeto que contiene la información recuperada del archivo de
%    audio.
% -------------------------------------------------------------------------

%fprintf('Reading audio file...\n');
%fprintf('  File: %s.\n', filePath);

[X, fs] = audioread(filePath);

if size(X,2) == 1
    x = X;
else
    x = 0.5 * sum(X,2);
end

audio = Audio(x, fs);

%fprintf('Reading audio file: OK!\n\n');

end