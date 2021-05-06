function spc = quantizeSpectrogram(spc, config)
%quantizeSpectrogram Cuantifica el spectrograma linear en bandas
%logarítmicas.
%   Parámetros de entrada:
%    - spc: Objeto que contiene el espectrograma de la señal de audio.
%    - config: Objeto que contiene la configuración.
%   Parámetros de salida:
%    - spc: Objeto que contiene la cuantificación del espectrograma.

%% Configuración de la cuantificación.
fmin = config.QuantMinFreq;
Nb   = config.QuantBands;

%% Cálculo de las bandas de entrada y sus límites.
F    = spc.Frequencies(2:end);
dF   = length(F);
Fmin = F - (spc.Audio.Fs / dF) / 2;
Fmax = F + (spc.Audio.Fs / dF) / 2;

%% Cálculo de las bandas de salida y sus límites.
j    = (1:Nb)';                         % Índice de la banda
B    = fmin * 2 .^((j-1)/12);           % Frecuencia central
Bmin = B - ((B/2) * (1 - 2^(-1/12)));   % Frecuencia inferior
Bmax = B + ((B/2) * (2^(1/12) - 1));    % Frecuencia superior

%% Inicialización de la matriz cuantificada.
C = zeros(length(B), length(F));

for j = 1 : Nb
    
    bmin = Bmin(j);
    bmax = Bmax(j);
    
    c1 = (Fmax > bmin) .* (Fmin < bmax);
    c2 = (min(Fmax,bmax) - max(Fmin,bmin)) ./ (Fmax - Fmin);
    C(j,:) = (c1 .* c2)';
    
end

%% Cálculo de la salida.
input  = spc.Data(2:end,:); % se elimina la componente continua
output = C * input;

%% Actualización del espectrograma
spc.Data = output;
spc.Frequencies = B;

end