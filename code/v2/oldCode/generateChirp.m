function audio = generateChirp(length, fs)
%generateChirp Genera una señal de audio de prueba (chirp) de la longitud
%especificada y con la frecuencia de muestreo dada.
%   Parámetros de entrada:
%    - length: Longitud en segundos del fragmento de audio.
%    - fs: Frecuencia de muestreo de la señal de audio.
%   Parámetros de salida:
%    - audio: Objeto que contiene la información de la señal generada.

fprintf('Generando audio de prueba...\n');

d = 1.0 / fs;
t = 0 : d : length - d;               
x = 0.5 * chirp(t, 50, length, 15000, 'q'); 

audio = Audio(x, fs);

fprintf('  OK!\n\n');

end