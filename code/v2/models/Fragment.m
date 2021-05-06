classdef Fragment
    %Fragment Encapsula información de un fragment de audio.
    %Ofrece mecanismos para establecer las marcas de tiempo de inicio y fin
    %de un fragmento de audio y su texto asociado (si existe).
    
    properties
        % Índice de base uno.
        Index;
        % Instante de tiempo de inicio (segundos).
        Start;
        % Instante de tiempo de fin (segundos).
        End;
        % Texto asociado.
        Text;
    end
    
    methods
        
        function obj = Fragment(index)        
            % Fragment(index) Constructor de la clase.
            % Inicializa una nueva instancia de un subtítulo.
            % Argumentos:
            % - index: Índice de base 1 del elemento.
            if nargin > 0
                obj.Index = index;
                obj.Start = 0;
                obj.End = 0;
                obj.Text = '';
            end
        end   
        
        function t = getDuration(obj)
            % getDuration() Obtiene la duración del fragmento.
            % Devuelve la duración en segundos.
            t = obj.End - obj.Start;
        end
    end
    
end

