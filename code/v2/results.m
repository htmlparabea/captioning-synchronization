%clear all;

addpath('models');

experiment = Experiment(0);
experiment.TrainFilepath       = '/Users/diegocarrero/Documents/TFM/Data/train/train-001-near.wav';
experiment.TestRootpath        = '/Users/diegocarrero/Documents/TFM/Data/test';
experiment.TestFolders         = ["001", "002"];
experiment.TestEnvironments    = "near"; %["mid", "far"];
experiment.ResultsRootpath     = '/Users/diegocarrero/Documents/TFM/Data/results/lsh';

config = initConfig();
config.LshTables                = 2;
config.LshKeyLength             = 2;
config.LookupLength             = 8;

perf = performance(experiment, config, 2);
fprintf('Recall            : %f\n', perf(1));
fprintf('Precision (4 seg.): %f\n', perf(2));
fprintf('Precision (2 seg.): %f\n', perf(3));
fprintf('\n');
fprintf('Success LSH       : %f\n', perf(4));
fprintf('Success system    : %f\n', perf(5));