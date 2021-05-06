function index = indexAudio(audio, config)
% index = indexAudio(audio, config)
% Realiza el indexado completo del audio dado.
%
% Parámetros de entrada:
%  - audio: Objeto que contiene la información de audio.
%  - config: Parámetros de configuración.
%
% Parámetros de salida:
%  - index: Tablas hash que contiene los descriptores indexados.
% -------------------------------------------------------------------------

%% Inicialización de variables
frgs = audio.getFragments(config.IndexLength);
K = length(frgs);
index = cell(1,K);

STOP = 0;
progress = 0;

fprintf('Indexing %d fragments \n', K);

%% Indexado de fragmentos
for k = 1 : K
    
    pp = mod(100*k/K, 10);   
    if pp < progress
        fprintf('-X');
    end
    progress = pp;
    
    % Obtención del audio correspondiente al fragmento.
    aud = fragmentAudio(audio, frgs(k));    
    if k == STOP
        plotAudio(aud, frgs(k));     
    end
    
    % Cálculo del espectrograma del audio.
    spc = computeSpectrogram(aud, config); 
    % Actualización de los tiempos del espectrograma.
    spc.Times = spc.Times + frgs(k).Start; 
    if k == STOP
        plotSpectrogram(spc, 'Linear spectrogram (S_k)');     
    end
     
    % Cuantificación del espectrograma.
    spc = quantizeSpectrogram(spc, config);
    if k == STOP
        plotSpectrogram(spc, 'Log spectrogram (S''_k)');     
    end    
    
    % Conversión de la escala lineal por una logarítmica.
    spc = scaleSpectrogram(spc, config);    
    if k == STOP
        plotSpectrogram(spc, 'Spectrogram Image (I_k)');     
    end
     
    % Cálculo de la SIFT del espectrograma.
    spc = computeDescriptors(spc, config);
    if k == STOP
        plotDescriptors(spc, 'Acoustic fingerprint');     
    end
    
    % Indexado de los descriptores.
    table = Table(frgs(k).Start, frgs(k).End, config);
    table = table.index(spc);
    table = table.trim();
    
    index{k} = table;
    if k == STOP
        pause
    end
    
end

fprintf('\n');

% % Create figure
% figure1 = figure;
% axes1 = axes('Parent', figure1);
% hold(axes1,'on');
% histogram(dcounts,'Parent',axes1,'BinMethod','auto');
% box(axes1,'on');
% 
% table.trim();
% 
% fprintf('Indexed: %d descriptors\n\n', table.Count);

end