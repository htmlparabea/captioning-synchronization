classdef Experiment
    % Experiment Define la ejecución de un experimento.
    
    properties
        
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
        
        function obj = Experiment()
            % Experiment Constructor de la clase.
           
            obj.TrainFilepath       = '/Users/diegocarrero/Documents/TFM/Data/train/train-001-near-short.wav';
            obj.TestRootpath        = '/Users/diegocarrero/Documents/TFM/Data/test';
            obj.TestFolders         = ["001"];  %["001", "002"];
            obj.TestEnvironments    = ["near"]; %["near", "mid", "far"];
            obj.ResultsRootpath     = '/Users/diegocarrero/Documents/TFM/Data/results';
        
        end
        
    end
    
end