classdef Table
    % Table Implementación de la tabla LSH.
    %    
    % Ofrece mecanismos para almacenar la información necesaria que permte
    % indexar mediante LSH los descriptores de los espectrogramas de la
    % señal de audio.    
    % ---------------------------------------------------------------------
  
    properties (SetAccess = private)
        % Marca de tiempo de inicio.
        StartTime
        % Marca de tiempo de fin.
        EndTime
        % Capacidad inicial.
        Capacity        
        % Número de vecinos que se recuperan cuando se realiza la búsqueda.
        Neighbors
        % Número de elementos contenidos.
        Count = 0;
        % Estructura que contiene la información necesaria para realizar el
        % indexado de los vectores mediante LSH.
        Lsh
        % Matriz (DxK) que contiene los vectores de los descriptores
        % indexados. La columna k contiene el descriptor k extraído de la
        % señal de audio.
        Data
        % Matriz (2xK) que contiene la localización tiempo-frecuencia de 
        % los descriptores. 
        Locations
    end
      
    methods
        
        function obj = Table(startTime, endTime, config)
            % obj = Table(index, timing, config)
            % Table Constructor de la clase.
            %            
            % Argumentos:
            %  - start: Marca de tiempo de inicio.
            %  - end: Marca de tiempo de fin.
            %  - config: Contiene la configuración.       
            % -------------------------------------------------------------

            if nargin > 0
                obj.StartTime = startTime;
                obj.EndTime = endTime;
                obj.Capacity = config.LshCapacity;
                obj.Neighbors = config.LshNeighbors;
                obj.Data = zeros(config.LshDimension, config.LshCapacity);
                obj.Locations = zeros(2, config.LshCapacity);
                
                l = config.LshTables;
                k = config.LshKeyLength;
                d = config.LshDimension;
                obj.Lsh = lsh('e2lsh', l, k, d, {});            
            end         
        end
        
        function obj = index(obj, spc)
            % obj = index(obj, des)
            % Indexa un espectrograma.
            %             
            % Parámetros de entrada:
            %  - spc: Espectrograma que se indexa.
            % -------------------------------------------------------------

            for n = 1 : length(spc.Descriptors)
                des = spc.Descriptors{n};
                
                index = obj.Count + 1;
                obj.Lsh = lshins(obj.Lsh, des.Value, index);
                obj.Data(:, index) = des.Value;
                obj.Locations(:, index) = [des.Time; des.Freq];
                obj.Count = index;                      
            end
            
        end
        
        function indexes = lookup(obj, des)
            % Realiza una búsqueda de descriptores indexados tomando como
            % ejemplo el desctiptor dado.
            % 
            % Parámetros de entrada:
            %  - des: Descriptor que se toma como query.
            % 
            % Parámetros de salida.
            %  - indexes : Vector que contiene los índices de los
            %    descriptores que forman parte del resultado.
            % -------------------------------------------------------------
            
            [indexes, ~] = lshlookup(des.Value,...
                obj.Data,...
                obj.Lsh,...
                'k',...
                obj.Neighbors);
        end
        
        function obj = trim(obj)
            % obj = trim(obj)
            % Elimina el espacio sobrante si el número de elementos es
            % inferior a la capacidad mínima. 
            % -------------------------------------------------------------
            
            if obj.Count < obj.Capacity
                obj.Data = obj.Data(:, 1:obj.Count);
                obj.Locations = obj.Locations(:, 1:obj.Count);
            end           
        end
        
        function showStats(obj)
            % showStats(obj)
            % Muestra estadísticas de la tabla y de los descriptores
            % indexados.      
            % -------------------------------------------------------------
         
            lshstats(obj.Lsh);
                   
        end
       
    end
end

