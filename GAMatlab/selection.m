function seln=selection(population,cumsump)
for i =1:2
    r = rand;
    prand=cumsump-r;
    j=1;
    while prand(j) <0
        j = j+1;
    end
    seln(i)=j;
end