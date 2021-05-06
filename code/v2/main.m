close all;
clear all;

addpath('models');
addpath('utils');
addpath('libs/lsh');
run('libs/vlfeat-0.9.21/toolbox/vl_setup.m')

experiment = Experiment(2);
experiment.TrainFilepath       = '/Users/diegocarrero/Documents/TFM/Data/train/train-001-near.wav';
experiment.TestRootpath        = '/Users/diegocarrero/Documents/TFM/Data/test';
experiment.TestFolders         = ["001", "002"];
experiment.TestEnvironments    = "near"; %["mid", "far"];
experiment.ResultsRootpath     = '/Users/diegocarrero/Documents/TFM/Data/results/lsh';

config = initConfig();
config.LshTables                = 2;
config.LshKeyLength             = 2;
config.LookupLength             = 8;

fprintf('### INDEXING ###\n');
fprintf('LshTables=%d & LshKeyLength=%d\n', [config.LshTables config.LshKeyLength]);
fprintf('Indexing %s\n', experiment.TrainFilepath);
fprintf('\n');

if exist('index','var') == 0
    index = indexAudioFile(experiment.TrainFilepath, config);
end

fprintf('### SEARCHING ###\n');
fprintf('Searching with %5.2f seg. fragments\n', config.LookupLength);

N = length(experiment.TestFolders);
M = length(experiment.TestEnvironments);

for n = 1 : N
    indexFilePath = experiment.getIndexFilePath(n);
    fprintf('Index file:\n');
    fprintf('%s\n', indexFilePath);
    
    files = readFileIndex(indexFilePath);
    ids = files{1};
    timestamps = files{2};    
       
    for m = 1 : M
        resultFilePath = experiment.getResultFilePath(n, m, config);    
        fprintf('Results file:\n');
        fprintf('%s\n', resultFilePath);
        
        fileID = fopen(resultFilePath, 'w+');
        t = -10; %Tiempo inicial (no establecido)
        ti = -10; %Tiempo desde el que se busca.
        
        K = length(ids);
        
        for k = 1 : K
            filePath = experiment.getTestFilePath(n, m, cell2mat(ids(k)));
            fprintf('Test file:\n');
            fprintf('%s\n', filePath);
            
            [t, ti, sk] = lookup(filePath, config, index, t, ti);
            
            writeResult(fileID, ids(k), timestamps(k), t, sk);
        end
        
        fclose(fileID);
    end
    
end