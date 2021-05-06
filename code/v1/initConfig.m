function config = initConfig()
% config = initConfig()
% Ofrece mecanismos para inicializar la configuración de los procesos de 
% indexado y búsqueda.
%
% Parámetros de salida:
%  - config: Objeto que contiene los parámetros de configuración.
% -------------------------------------------------------------------------

fprintf('Initializing config...\n');

config = Config();

%% Configuración de la duración de los fragmentos de audio
config.IndexLength   = 15;           % Longitud del fragmento en el indexado.
config.LookupLength  = 10.0;         % Longitud del fragmento en la búsqueda.

%% Configuración del espectrograma
config.SpectLength   = 8192;        % Número de muestras.
config.SpectOverlap  = 0.75;        % Solapamiento.
config.SpectWindow   = @hanning;    % Ventana aplicada.

%% Configuración del escalado
config.ScaleEnabled  = true;        % Normalización del espectrograma.

%% Configuración de la cuantificación
config.QuantMinFreq  = 80;          % Frecuencia inicial de la cuantificación.
config.QuantBands    = 88;          % Número de de bandas de cuantificación.

%% Configuración del indexado
config.LshTables     = 32;           % Número de tablas.
config.LshKeyLength  = 32;           % Longitud del índice.
config.LshDimension  = 128;         % Dimensión de los datos (longitu del descriptor).

fprintf('Initializing config: OK!\n\n');

end