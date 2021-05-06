classdef Experiment
    % Experiment Define la ejecución de un experimento.
    
    properties
        % Número de experimento
        Index;
        % [Train] - Ruta al archivo de entenamiento.
        TrainFilepath;
        % [Test] - Ruta a la carpeta raíz de los tests.
        TestRootpath;
        % [Test] - Carpetas de archivos de test.
        TestFolders;
        % [Test] - Ambientes en los que se realizan los tests.
        TestEnvironments;
        % [Output] - Carpeta en la que se depositan los resultados.
        ResultsRootpath;
        
    end
    
    methods
        
        function obj = Experiment(index)          
            % Experiment Constructor de la clase.
            
            obj.Index = index;   
        end
        
        function filePath = getIndexFilePath(obj, n)
            % Obtiene la ruta al archivo de índice de archivos de test.
            
            filePath = sprintf('%s/%s/%s-index.txt',...
                obj.TestRootpath,...
                obj.TestFolders(n),...
                obj.TestFolders(n));         
        end
        
        function filePath = getResultFilePath(obj, n, m, config)
            % Obtiene la ruta al archivo de resultados.
            
            filePath = sprintf('%s/L%d-K%d-T%d/%s-%s-%d.res.txt',...
                obj.ResultsRootpath,...
                config.LshTables,...
                config.LshKeyLength,...
                config.LookupLength,...
                obj.TestFolders(n),...
                obj.TestEnvironments(m),...
                obj.Index);
            
            [folder, ~, ~] = fileparts(filePath);
            mkdir(folder);
        end
        
        function filePath = getTestFilePath(obj, n, m, fileName)
            % Obtiene la ruta al archivo de test.
             
            filePath = sprintf('%s/%s/%s/test-%s-%s-%s.wav',...
                obj.TestRootpath,...
                obj.TestFolders(n),...
                obj.TestEnvironments(m),...
                obj.TestFolders(n),...
                obj.TestEnvironments(m),...
                fileName);
        end
        
    end
    
end