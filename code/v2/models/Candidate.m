classdef Candidate
    % Candidate Candidato obtenido en el proceso de búsqueda
    %    
    % Ofrece mecanismos para almacenar la información necesaria que permte
    % indexar mediante LSH los descriptores de los espectrogramas de la
    % señal de audio.    
    % ---------------------------------------------------------------------

    properties
        % Índice
        Index
        % Instante de tiempo
        Time
        % Frecuencia
        Freq
    end
       
    methods
        
        function obj = Candidate(index, time, freq)
            % obj = Candidate(index, value)
            % Table Constructor de la clase.
            %            
            % Argumentos:
            %  - index: Índice del candidato.
            %  - time : Instante de tiempo.
            %  - freq : Valor de frecuencia.
            % -------------------------------------------------------------
            if nargin > 0
                obj.Index = index;
                obj.Time = time;
                obj.Freq = freq;
            end
        end
        
    end
    
end