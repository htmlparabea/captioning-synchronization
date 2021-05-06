function perf = performance(experiment, config, repetitions)

N = length(experiment.TestFolders);
M = length(experiment.TestEnvironments);

perfs = zeros(N*M*repetitions, 5);
k = 1;

for j = 1 : repetitions
    experiment.Index = j;
    
    for n = 1 : N
        
        for m = 1 : M
            
            resultFilePath = experiment.getResultFilePath(n, m, config); 
            fileID = fopen(resultFilePath, 'r');
            data = textscan(fileID, '%s %f %f %d');
            fclose(fileID);
            
            % Número total de elementos testeados...
            total = length(data{4});
            % Número de elementos recuperados...
            rec = sum(data{4} > 0);
            % Número de elementos posicionados dentro de 4 segundos...
            pr4 = sum(data{4} > 0 & (abs(data{3} - data{2}) < 4));
            % Número de elementos posicionados dentro de 2 segundos...
            pr2 = sum(data{4} > 0 & (abs(data{3} - data{2}) < 2));
               
            % Recall
            recall = rec / total;
            if rec > 0 
                % Precisión para 4 segundos
                prec4 = pr4 / rec;
                % Precisión para 2 segundos
                prec2 = pr2 /rec;
            else
                prec4 = 0;
                prec2 = 0;
            end
            
            % Tasa de acierto LSH
            prl = recall * prec2;
            % Preción del sistema
            prt = sum(abs(data{3} - data{2}) < 2) / total;
            
            perfs(k,:) = [recall, prec4, prec2, prl, prt];
            k = k + 1;
        end
    end
end

perfs

[N,~] = size(perfs);

if N > 1
    perf = mean(perfs);
else
    perf = perfs;
end
end