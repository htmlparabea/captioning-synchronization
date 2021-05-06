function results = searchCandidates(spc, config, table)
% cnd = searchCandidates(spc, table)
% Realiza la búsqueda de candidadtos para los descriptores del
% espectrograma spc dado.
%
% Parámetros de entrada:
%  - spc: Espectrograma cuyos descriptores se utilizan para buscar
%  candidatos.
%  - config: Parámetros de configuración.
%  - table: Tabla de descriptores utilizada en el proceso de búsqueda.
%
% Parámetros de salida:
%  - candidates: Cell array con los candidatos.
% -------------------------------------------------------------------------

items = {};
J = length(spc.Descriptors);
k = 0;

for j = 1 : J
    
    des = spc.Descriptors{j};
    tmp = table.lookup(des);
    indexes = unique(tmp);
    
    if ~isempty(indexes)
        
        index = indexes(1);
        % Instante de tiempo del descriptor
        time = table.Locations(1, index);
        % Frecuencia
        freq = table.Locations(2, index);
            
        B = des.Freq;
        Bmin = B - ((B/2) * (1 - 2^(-4/12)));
        Bmax = B + ((B/2) * (2^(4/12) - 1));
        st = 0;
            
        if freq > Bmin && freq < Bmax
            result = Result(des);
            result.Candidate = Candidate(index, time, freq);
            
            k = k + 1;
            items{k} = result;
            st = 1;        
        end
            
        fprintf('Query: %g --> Candidate: t=%g, f=%g %g (%g - %g) \n', [des.Freq time freq st Bmin Bmax]);
        
    end
    
end

results = {};
J = length(items);
k = 0;

times = zeros(1,J);
for j = 1 : J
    times(j) = items{j}.Candidate.Time;
end

med = median(times);

for j = 1 : J
    result = items{j};
    time = result.Candidate.Time;
   
    if abs(time - med) < 1.5 * config.LookupLength
        k = k + 1;
        results{k} = result;
    end
    
end

end