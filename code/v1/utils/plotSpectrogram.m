function plotSpectrogram(spc, plotTitle)
% plotSpectrogram(spc, plotTitle)
% Dibuja el espectrograma dado.
%
% Parámetros de entrada:
%  - spc: Objeto que contiene la información del espectrograma.
%  - plotTitle: Título del gráfico.
%
% -------------------------------------------------------------------------
figure;

t = spc.Times;
f = spc.Frequencies;
x = spc.Data;  

surf(t, f, x, 'EdgeColor','none');
ylabel({'Frequency (Hz)'});
xlabel({'Time (s)'});
title({plotTitle});

axis xy;  
axis tight;
view(0,90);
    
h = colorbar;
h.Label.String = 'Value';

end