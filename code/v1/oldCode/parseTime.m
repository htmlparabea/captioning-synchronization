function t = parseTime(str)
%parseTime Procesa una cadena de texto en la forma 00:00:00,000 para
%obtener su representación en segundos.
%   Parámetros de entrada:
%    - str: Cádena de texto que contiene la marca de tiempo.
%   Parámetros de salida:
%    - t: Instante de tiempo equivalente en segundos.

expr = '(?<h>\d{2}):(?<m>\d{2}):(?<s>\d{2}),(?<ms>\d{3})';
tokens = regexp(str, expr, 'names');
t = 0;
if length(tokens) == 1
    token = tokens(1);
    
    t = t + (3600 * str2double(token.h));
    t = t + (60 * str2double(token.m));
    t = t + (str2double(token.s));
    t = t + (str2double(token.ms) / 1000);
end

end