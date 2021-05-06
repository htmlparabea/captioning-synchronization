function spc = computeDescriptors(spc, config)
% spc = computeDescriptors(spc, config) Calcula los descriptores SIFT del
% fragmento de espectrograma dado.
%   Ofrece mecanismos para calcular la transformada SIFT. Más información
%   en la siguiente URL: http://www.vlfeat.org/overview/sift.html
%
%   Parámetros de entrada:
%    - spc: Objeto que contiene la información del espectrograma.
%    - config: Objeto que contiene la configuración actual.
%
%   Parámetros de salida:
%    - spc: Objecto que contiene la información del espectrograma a la que
%           se ha agregado la información de los descriptores.
% -------------------------------------------------------------------------

%% Cálculo de los descriptores SIFT.
% The matrix f has a column for each frame.
% A frame is a disk of center f(1:2), scale f(3) and orientation f(4). 

[f, d] = vl_sift(single(spc.Data)) ;

%% Procesado de los descriptores
% A partir de f(1) y f(2) hay que estimar el instante de tiempo y la
% frecuencia del descriptor.
% f(1) -> tiempo...
% f(2) -> frecuencia...
K = size(d, 2);
spc.Descriptors = cell(1,K);

for k = 1 : K
    % Estimación del tiempo...
    li = ceil(f(1,k));
    ui = floor(f(1,k));
    time = spc.Times(li) + (f(1,k) - li) * (spc.Times(ui) - spc.Times(li));
    
    % Estimación de la frecuencia...
    li = ceil(f(2,k));
    ui = floor(f(2,k));
    freq = spc.Frequencies(li) + (f(2,k) - li) * (spc.Frequencies(ui) - spc.Frequencies(li));
    
    % Normalización del vector de descriptores...
    tmp = double(d(:,k));
    nn = norm(tmp);
    val = tmp ./ nn;
    
    spc.Descriptors{k} = Descriptor(time, freq, val);
end

% %% Verbose
% if config.ShowImages == true
%     fprintf('Renderizando descriptores SIFT...\n');  
%     fprintf('Number of descriptors: %d.', K);
%     
%     figure, imagesc(spc.Data);
%     h2 = vl_plotframe(f) ;
%     set(h2,'color','k','linewidth',1) ;
% end

end