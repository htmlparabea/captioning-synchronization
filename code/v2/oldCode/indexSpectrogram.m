function table = indexSpectrogram(spc, config)
% index = indexSpectrogram(spc, config)
% Realiza el indexado del espectograma.
%
% Parámetros de entrada:
%  - spc: Objecto que contiene la información del espectrograma.
%  - config: Parámetros de configuración.
%
% Parámetros de salida:
%  - table: Tabla hash que contiene los descriptores indexados.
% -------------------------------------------------------------------------
index = 0;
timing = 0;

table = Table(index, timing, config);
table = table.index(spc);

end