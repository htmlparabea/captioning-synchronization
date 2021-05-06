classdef Spectrogram
    %Spectrum Encapsula información sobre el espectrograma.
    %Ofrece mecanismos para almacenar el espectrograma de una señal de
    %audio.
    
    properties
        % Objeto que contiene el fragmento de audio .
        Audio;
        % Matriz (MxN) que contiene el espectrograma (STFT) del fragmento
        % de audio. Data(i,j) contiene la energía de la frecuencia
        % Frequencies(i) para el instante Times(j).
        Data;          
        % Vector (Mx1) que contiene las frecuencias centrales.
        Frequencies;
        % Vector (1xN) que contiene los instantes de tiempo.
        Times;
        % Longitud de la STFT.
        Length;      
        % Solapamiento (%).
        Overlap;
        % Tipo de ventana empleada.
        Window;
        % Colección de desctriptores.
        Descriptors;
    end
    
    methods
        
        function obj = Spectrogram(data, frequencies, times)
            %Spectrogram(data, frequencies, times) Constructor de la clase.
            %Inicializa una nueva instancia de un espectrograma.
            %Argumentos:
            % - data: Matriz (MxN) que contiene el espectrograma.
            % - frequencies: Vector (Mx1) que contiene los valores de las
            %   frecuencias.
            % - times: Vector (1xN) que contiene los valores de los
            %   instantes de tiempo.
            if nargin > 0
                obj.Data = data;
                obj.Frequencies = frequencies;
                obj.Times = times;
                obj.Descriptors = {};
            end  
        end
             
        function obj = setConfig(obj, config)
            %setConfig Actualiza la configuración. 
            %Actualiza el estado del objeto con los valores de
            %configuración utilizados.
            
            obj.Length = config.SpectLength;
            obj.Overlap = config.SpectOverlap;
            obj.Window = config.SpectWindow;          
        end
        
    end
    
end