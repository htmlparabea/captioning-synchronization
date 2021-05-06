function files = readFileIndex(filePath)

fileID = fopen(filePath, 'r');
files = textscan(fileID, '%s %f');
fclose(fileID);

end