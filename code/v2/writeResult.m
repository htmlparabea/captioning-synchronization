function writeResult(fileID, file, timestamp, tk, sk)

text = sprintf('%s %f %f %d\n',...
    cell2mat(file),...
    timestamp,...
    tk,...
    sk);

fprintf(fileID, text);
fprintf(text);
fprintf('\n');

end