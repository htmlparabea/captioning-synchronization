function frgs = readSrt(filePath)
% frgs = readSrt(filePath)
% Abre el archivo SRT especificado y realiza la lectura de las regiones
% especificadas.
%
% Parámetros de entrada
%  - filePath: Ruta absoluta al archivo de subtítulos cuyo contenido se
%    recupera.
% Parámetros de salida:
%  - frgs: Array que contiene los fragmentos de audio asociados a 
%    los subtítulos del archivo.
% -------------------------------------------------------------------------

fprintf('Reading SRT file...\n');
fprintf('  File: %s.\n', filePath);

%% Expresiones regulares para encontrar los parámetros
indexRgx = '^(?<index>\d+)\s+';
timeRgx  = '(?<start>\d{2}:\d{2}:\d{2},\d{3})\s+-->\s+(?<end>\d{2}:\d{2}:\d{2},\d{3})\s+';
textRgx  = '(?<text>.+)$';
rgx = strcat(indexRgx, timeRgx, textRgx);

%% Estructura para almacenar la información recuperada
tmp(5000, 1) = Fragment();
counter = 0;

%% Apertura del archivo
fid = fopen(filePath);

%% Procesado del archivo
str = '';
line = fgetl(fid);
space = " ";
while ischar(line)
    
    if strcmp(line, '') == true
       tokens = regexp(str, rgx, 'names', 'lineanchors');
          
       % Se procesa el buffer.     
       for k = 1 : length(tokens)
           token = tokens(k);
          
           % Se crea el fragmento
           frg = Fragment(str2double(token.index));
           frg.Start = parseTime(token.start);
           frg.End = parseTime(token.end);
           frg.Text = token.text;
           
           counter = counter + 1;
           tmp(counter, 1) = frg;
       end
          
       % Se reinicia el buffer.
       str = '';
    else
        % Se agrega el texto al buffer.
        str = strcat(str, line, space);      
    end
    
    % Lectura de la siguiente línea
    line = fgetl(fid);
end

%% Cierre del archivo
fclose(fid);

%% Devolución de los datos recuperados
frgs = tmp(1:counter, :);

fprintf('  OK!\n\n');

end