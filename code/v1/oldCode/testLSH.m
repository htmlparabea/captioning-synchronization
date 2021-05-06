%% Limpieza de variables...
clearvars;
close all;

%% Configuración de librerías...
addpath('models');
addpath('utils');
addpath('libs/lsh');
run('libs/vlfeat-0.9.21/toolbox/vl_setup.m')

%% Inicialización de la configuración
config = initConfig();

%% Lectura del archivo de audio
audPath = 'audio/record-001.wav';
audio = readAudio(audPath);

%% Inicialización de variables
frgs = audio.getFragments(config.IndexLength);
K = length(frgs);
spcs(K, 1) = Spectrogram();

%% Extracción de descriptores.
for k = 1 : K
        
    fprintf('Processing item %d / %d \n', [k; K]);
    
    % Obtención del audio correspondiente al fragmento.
    aud = fragmentAudio(audio, frgs(k));       
    % Cálculo del espectrograma del audio.
    spc = computeSpectrogram(aud, config); 
    % Actualización de los tiempos del espectrograma.
    spc.Times = spc.Times + frgs(k).Start; 
    % Cuantificación del espectrograma.
    spc = quantizeSpectrogram(spc, config);
    % Conversión de la escala lineal por una logarítmica.
    spc = scaleSpectrogram(spc, config);         
    % Cálculo de la SIFT del espectrograma.
    spc = computeDescriptors(spc, config);

    spcs(k) = spc;
    
end

%% Configuración de LSH
Keys = [8,16,32,64];
W = length(Keys);
Tables = [4,8];
L = length(Tables);
    
for l = 1 : L
    
    for w = 1 : W
        
        fprintf('####\n');
         config.LshTables = Tables(l);
         config.LshKeyLength = Keys(w);
         
         s = cputime;
         table = Table(config);
         
         for k = 1 : K
             
             spc = spcs(k);
             table = indexSpectrogram(spc, table);

         end
         
         t = cputime - s;
         fprintf('Elapsed time %g \n', t);
         
         table.showStats();
         
         whos table
         clear table;
    
         fprintf('\n');
    end
    
end