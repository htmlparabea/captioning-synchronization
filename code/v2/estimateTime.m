function t = estimateTime(res)
% t = estimateTime(res)
% Realiza la estimación del tiempo de inicio del fragmento dado.
%
% Parámetros de entrada:
%  - res: Resultados de la búsqueda.
%
% Parámetros de salida:
%  - t: Estimación del tiempo de inicio. Si no se puede estimar el tiempo
%       del fragmento, se devuelve -1.
% -------------------------------------------------------------------------

K = length(res);

if K == 0
    t = -1;
    return;
end

t = 0.0;
c = 0;

for k = 1 : K
           
    ti = res{k}.Candidate.Time;
    tf = res{k}.Query.Time;
    t = t + (ti - tf);
    c = c + 1;    
    
end

if c > 1
    t = t / c;
else
    t = -1;
end

end