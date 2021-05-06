function table = indexSpectrogram(spc, table)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for n = 1 : length(spc.Descriptors)
    
    table = table.index(spc.Descriptors{n});
    
%     index = index + 1;
%     des = spc.Descriptors{n};
%     %des.Id = index;
%     %des.Spectrogram = spc;
% 
%     table = lshins(table, des.Value, index);
%     x(:, index) = des.Value;
    
end

end