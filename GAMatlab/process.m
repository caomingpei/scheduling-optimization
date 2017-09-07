%生成随机工序表
function hlist = process()
hlist=[];
seq = zeros(1,9);
while(min(seq)<4)
p = randi([1,9]);
if seq(p) <4
    hlist=[hlist,p];
    seq(p)=seq(p)+1;
end
end
