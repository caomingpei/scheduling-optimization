function used = machine_random(W,i)
Wp = W(i,:);
m = find(Wp);
p = min(m);
q = max(m);
if isempty(m)
    used = 0;
else
    used = randi([p,q]);
end