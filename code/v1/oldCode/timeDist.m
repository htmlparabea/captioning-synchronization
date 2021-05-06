function s = timeDist(one, other)

s = 0;
            
if one.Time > other.Time               
    s = 50000; %one.Time - other.Time;          
end
end