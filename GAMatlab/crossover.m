function scro = crossover(population,seln,pc)
BitLength = size(population,2);
pcc=IfCroIfMut(pc);
if pcc ==1
    chb = round(rand*(BitLength-2))+1;
    scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];
    scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];
else
scro(1,:)=population(seln(1),:);
scro(2,:)=population(seln(2),:);
end