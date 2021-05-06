function idxs = findTables(index, t)
% idxs = findTables(index, ts)
% Determina los índices de las tablas en las que se ha de buscar.
%
% Parámetros de entrada:
%  - index: Colección de tablas.
%  - t: Instante de tiempo desde el que se busca.
%
% Parámetros de salida:
%  - idxs: Array que contiene los índices de las tablas en las que se
%          busca.
% -------------------------------------------------------------------------

K = length(index);

if t <= index{1}.StartTime
    idxs = [1, 2];
elseif t > index{K}.EndTime
    idxs = [K-1, K];
elseif t > index{K}.StartTime && t < index{K}.EndTime
    idxs = [K-1, K];
else  
    for k = 1 : K - 1
        if t > index{k}.StartTime && t < index{k}.EndTime
            idxs = [k, k+1];         
            break;
        end     
    end   
end

end