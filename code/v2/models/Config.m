classdef Config
    % Config Define y almacena las variables de configuración del proceso.
    %
    % Permite compartir las variables de configuración entre los distintos
    % pasos del proceso de indexado y búsqueda.
    % ---------------------------------------------------------------------
    
    properties
        % Duración en segundos de los fragmentos extraídos del archivo a
        % indexar.
        IndexLength;
        % Duración en segundos de los fragmentos utilizados para realizar
        % la estimación de los tiempos.
        LookupLength;
        % [FFT] Número de muestras utilizadas para calcular el
        % espectrograma.
        SpectLength;
        % [FFT] Porcentaje de solapamiento en el cálculo del espectrograma.
        SpectOverlap;
        % [FFT] Tipo de ventana utilizada para segmentar la señal en el
        % cálculo.
        % del espectrograma.
        SpectWindow;
        % [Scale] Indica si se aplica escalado en la amplitud del
        % espectrograma.
        ScaleEnabled;
        % [Quant] Frecuencia inicial de la cuantificación del
        % espectrograma.
        QuantMinFreq;
        % [Quant] Número de bandas.
        QuantBands;
        % [LSH] - Capacidad inicial de la tabla.
        LshCapacity;
        % [LSH] - Número de tablas para indexar.
        LshTables;
        % [LSH] - Longitud de las claves.
        LshKeyLength;
        % [LSH] - Dimensión de los datos.
        LshDimension;
        % [LSH] - Número de vecinos que se recuperan en la búsqueda.
        LshNeighbors;
    end
    
    methods
        
        function obj = Config()
            % Config Constructor de la clase.
            %
            % Inicializa una nueva instancia con los valores por defecto.
            % -------------------------------------------------------------

            obj.IndexLength  = 30.0;
            obj.LookupLength = 5.0;
            obj.SpectLength  = 8192;
            obj.SpectOverlap = 0.75;
            obj.SpectWindow  = 'hanning';
            obj.ScaleEnabled = true;
            obj.QuantMinFreq = 80;
            obj.QuantBands   = 88;
            obj.LshCapacity  = 1800;
            obj.LshTables    = 20;
            obj.LshKeyLength = 24;
            obj.LshDimension = 128;
            obj.LshNeighbors = 1;
        end
        
    end
    
end