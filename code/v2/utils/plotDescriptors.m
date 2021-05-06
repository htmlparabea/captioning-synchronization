function plotDescriptors(spc, plotTitle)
% plotDescriptors(spc, plotTitle)
% Dibuja el espectrograma dado y sus descriptores.
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
hold on;

descs = spc.Descriptors;
J = length(descs);

for j = 1 : J
   des = descs{j}; 
   tmp = plot3(des.Time, des.Freq, 1.0,'o');
   set(tmp, 'color', 'k', 'linewidth',5);
end

ylabel({'Frequency (Hz)'});
xlabel({'Time (s)'});
title({plotTitle});

axis xy;  
axis tight;
view(0,90);
    
h = colorbar;
h.Label.String = 'Value';

end