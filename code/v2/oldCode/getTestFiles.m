function files = getTestFiles(folderPath)

all = dir(folderPath);
K = length(all);
j = 1;

for k = 1 : K
    
    tmp = all(k);
    [~, ~, ext] = fileparts(tmp.name);
    
    if tmp.isdir == 0 && strcmp(ext, '.wav') == 1   
        files(j) = tmp;
        j = j + 1;
    end
end