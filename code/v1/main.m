close all;

addpath('models');
addpath('utils');
addpath('libs/lsh');
run('libs/vlfeat-0.9.21/toolbox/vl_setup.m')

experiment = Experiment();
config = initConfig();
config.LshTables     = 32;
config.LshKeyLength  = 32;
config.LookupLength  = 10;

fprintf('### INDEXING ###\n');
fprintf('LshTables=%d & LshKeyLength=%d\n', [config.LshTables config.LshKeyLength]);
fprintf('Indexing %s\n', experiment.TrainFilepath);
fprintf('\n');

cnd = exist('table','var');
if cnd == 0
    table = indexAudioFile(experiment.TrainFilepath, config);
end

fprintf('### SEARCHING ###\n');
fprintf('Searching with %5.2f seg. fragments\n', config.LookupLength);

N = length(experiment.TestFolders);
M = length(experiment.TestEnvironments);

for n = 1 : N
    indexFilePath = sprintf('%s/%s/%s-index-short.txt',...
        experiment.TestRootpath,...
        experiment.TestFolders(n),...
        experiment.TestFolders(n));   
    disp(indexFilePath);
    
    fileID = fopen(indexFilePath, 'r');
    tmp = textscan(fileID, '%s %f');
    files = tmp{1};
    timestamps = tmp{2};
    fclose(fileID);
    
    K = length(files);
    
    for m = 1 : M
        
        outputFilePath = sprintf('%s/L%d-K%d-T%d/%s-%s.res.txt',...
            experiment.ResultsRootpath,...
            config.LshTables,...
            config.LshKeyLength,...
            config.LookupLength,...
            experiment.TestFolders(n),...
            experiment.TestEnvironments(m));
        disp(outputFilePath);
        
        fileID = fopen(outputFilePath, 'w+');
         
        for k = 1 : K
        
            filePath = sprintf('%s/%s/%s/test-%s-%s-%s.wav',...
                experiment.TestRootpath,...
                experiment.TestFolders(n),...
                experiment.TestEnvironments(m),...
                experiment.TestFolders(n),...
                experiment.TestEnvironments(m),...
                cell2mat(files(k)));
            disp(filePath);
        
            t = lookup(filePath, config, table);
            
            fprintf('%s %f %f\n', cell2mat(files(k)), timestamps(k), t);
            fprintf(fileID, '%s %f %f\n', cell2mat(files(k)), timestamps(k), t);
        end
        
        fclose(fileID);
        
    end
    
end