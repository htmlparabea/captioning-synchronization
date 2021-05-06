function spc = computeSpectrogram(aud, config)
% spc = computeSpectrogram(aud, config)
% Calcula el espectrograma mediante la transformada de Fourier.
%
% Parámetros de entrada:
%  - aud: Objeto que contiene el fragmento de audio cuyo espectrograma se
%    calcula.
%  - config: Objeto que contiene la configuración.
%
% Parámetros de salida:
%  - spect: Objeto que contiene el espectrograma del fragmento de audio.
% -------------------------------------------------------------------------

%% Configuración del espectrograma
l = config.SpectLength;
o = round(config.SpectOverlap * l, 0);
w = window(config.SpectWindow, l);               

%% Cálculo del espectrograma
% S tiene tantas filas como elementos tenga F.
% S tiene tantas columnas como elementos tenga T.
% S(i,j) contiene el valor del espectrograma para la frecuencia F(i) en el
% instnte de tiempo T(j).

[S, F, T] = spectrogram(aud.Data, w, o, [], aud.Fs);
spc = Spectrogram(abs(S), F, T);
spc.Audio = aud;
spc = spc.setConfig(config);

end