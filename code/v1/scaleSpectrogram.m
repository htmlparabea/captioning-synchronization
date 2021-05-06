function spc = scaleSpectrogram(spc, config)
%scaleSpectrogram Escala el espectrograma.
%Transform.
%   Parámetros de entrada:
%    - spc: Objeto que contiene el espectrograma de la señal de audio.
%    - config: Objeto que contiene la configuración.
%   Parámetros de salida:
%    - spc: Objeto que contiene el escalado del espectrograma.

%% Se aplica el logaritmo del valor.
S = log(spc.Data);

if config.ScaleEnabled == true
    Smax = max(S, [], 'all');
    Smin = min(S, [], 'all');
    spc.Data = mat2gray(S, [Smin Smax]);
else
    spc.Data = S;
end

% if config.ShowImages == true   
%     fprintf('Renderizando espectrograma escalado...\n');   
%     figure, imagesc(spc.Data);
% end

end