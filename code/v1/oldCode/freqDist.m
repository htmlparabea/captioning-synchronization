function s = freqDist(one, other)

ds = norm(one.Value - other.Value);
df = abs(one.Freq - other.Freq) / 22000;
s = ds + df;

end