function t = estimateTime2(res)
% table = estimateTime2(res)
% Realiza la estimación del tiempo de inicio del fragmento dado.
%
% Parámetros de entrada:
%  - res: Resultados de la búsqueda.
%
% Parámetros de salida:
%  - t: Estimación del tiempo de inicio.
% -------------------------------------------------------------------------

K = length(res);
kk = 0;
tres(K,1) = Result();
for k = 1 : K
    
    if ~isempty(res(k).Candidates)
        kk = kk + 1;
        tres(kk) = res(k);
    end
end

res = tres(1:kk);
K = length(res);

if K == 0
    t = 0;
    return;
end

path = cell([K 1]);
cost = cell([K 1]);

M = length(res(1).Candidates);
tmp = zeros([1 M]);

for k = 2 : K
     
    M = length(res(k-1).Candidates);
    N = length(res(k).Candidates);
    CC = zeros([M N]);
   
    for n = 1 : N
        fdn = freqDist(res(k).Candidates(n), res(k).Query);
        
        for m = 1 : M
            fdm = freqDist(res(k-1).Candidates(m), res(k-1).Query);
            td = timeDist(res(k-1).Candidates(m), res(k).Candidates(n));
 
            CC(m,n) = fdn + fdm + td;
        end
    end
    
    [Y, I] = min(CC);
    
    path{k} = I;
    cost{k} = Y + tmp;
    tmp = cost{k};
    
end

t = 0;
c = 1;

% Se busca el camino con menor coste...
[~, i] = min(cost{K}); %II marca el candidato final seleccionado.

for k = K : -1 : 2
    
     if ~isempty(res(k).Candidates)
         
        ti = res(k).Candidates(i).Time;
        tf = res(k).Query.Time;
        t = t + (ti - tf);
        c = c + 1;
        
        idxs = path{k};
        idx = idxs(i);

        i = idx;
        
     end
end

t = t/c;

end