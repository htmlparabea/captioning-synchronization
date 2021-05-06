function  generateTestData(inputFilename, outputFolder, duration)

addpath('models');

fprintf('Preparing audio file...\n');
fprintf('  Input File: %s.\n', inputFilename);
fprintf('  Output Path: %s.\n', outputFolder);

[~, name, ext] = fileparts(inputFilename);

% Lectura del archivo de entrada...
audio = readAudio(inputFilename);

% Determinación del número de fragmentos
frgs = audio.getFragments(duration);
K = length(frgs);

for k = 1 : K
       
    fprintf('Saving item %d / %d \n', [k; K]);     
    filename = sprintf('%s%s%s',[name num2str(k,'-%03.f') ext]);
    filepath = fullfile(outputFolder, filename);
   
    output = fragmentAudio(audio, frgs(k));   
     
    output.write(filepath);
    
end

fprintf('Preparing adio file: OK!\n');

end