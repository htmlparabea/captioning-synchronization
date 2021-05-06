classdef Audio
    % Audio Encapsula información sobre la señal de audio.
    %
    % ---------------------------------------------------------------------
    % Almacena el vector de muestras de audio y la frecuencia de muestreo
    % de la señal.
    % ---------------------------------------------------------------------
    
    properties
        %Vector (Nx1) que contiene la señal de audio en formato mono.
        Data;
        %Frecuencia de muestreo.
        Fs;
    end
    
    methods
        
        function obj = Audio(data, fs)
            % Audio(data, fs) Constructor de la clase.
            %
            % -------------------------------------------------------------
            % Inicializa una nueva señal de audio muestreda con una cierta
            % frecuencia de muestreo.
            % Argumentos:
            % - data: Vector (Nx1) que contiene las muestras de audio.
            % - fs: Frecuencia de muestreo.
            % -------------------------------------------------------------
            if nargin > 0
                obj.Data = data;
                obj.Fs = fs;
            end          
        end
        
        function duration = getDuration(obj)
            % duration = getDuration()
            %
            % -------------------------------------------------------------
            % Obtiene la duración en segundos del archivo de audio.
            % -------------------------------------------------------------
            
            duration = length(obj.Data) / obj.Fs;
        end
        
        function fragments = getFragments(obj, length)
            % fragments = getFragments(length)
            %            
            % -------------------------------------------------------------
            % Obtiene el listado de fragmentos en los que se divide el
            % archivo de audio.
            % -------------------------------------------------------------

            duration = obj.getDuration();
            K = floor(duration / length);
            fragments(K, 1) = Fragment();

            for k = 1 : K
                fragment = Fragment(k);
                fragment.Start = (k-1) * length;
                fragment.End = k * length;
                fragments(k) = fragment;
            end
        end
        
        function write(obj, fileName)
            % write(fileName)
            %            
            % -------------------------------------------------------------
            % Escribe el contenido del audio en el archivo especificado.
            % -------------------------------------------------------------
            
            audiowrite(fileName, obj.Data, obj.Fs);          
        end
        
    end
    
end