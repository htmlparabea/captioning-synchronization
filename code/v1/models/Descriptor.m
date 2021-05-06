classdef Descriptor
    %Descriptor Encapsula información sobre un descriptor extraído del
    %espectrograma de una señal de audio.
    %   Detailed explanation goes here
    
    properties
        % Espectrograma al que pertenece.
        % Spectrogram;
        % Instante de tiempo asociado al descriptor.
        Time;
        % Frecuencia en la que se localiza el descriptor.
        Freq;
        % Vector que contiene el descriptor SIFT.
        Value;
    end
    
    methods
        
        function obj = Descriptor(time, freq, value)
            %Descriptor Constructor de la clase.
            %   Inicializa un nuevo objeto de la clase.
            %Argumentos:
            % - time: Instante de tiempo (en segundos) asociado al descriptor.
            % - freq: Frecuencia en la que se localiza el descriptor.
            % - value: Descriptor SIFT.
            if nargin > 0
                obj.Time = time;
                obj.Freq = freq;
                obj.Value = value;
                %obj.Spectrogram = spc;
            end
        end

    end
    
end