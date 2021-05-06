% Sript de test.

%% Limpieza de variables...
clearvars;
close all;

%% Configuración de librerías...
addpath('libs/lsh');
addpath('utils');
run('libs/vlfeat-0.9.21/toolbox/vl_setup.m')

%% Inicialización de la configuración
config = initConfig();

%% Inicialización de variables
audio = generateChirp(6.0, 48000);

%% Indexado del contenido
table = indexAudio(audio, config);