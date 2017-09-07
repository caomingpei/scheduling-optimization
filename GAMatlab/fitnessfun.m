function[Fitvalue,cumsump]=fitnessfun(population)
global BitLength
global boundsbegin
global boundsend
popsize=size(population,1);
for i = 1:popsize
    x=transform2to10(population(i,:);
xx=boundsbegin+x*(boundsend-boundsbegin)/(power((boundsend),BitLength)-1);
Fitvalue(i)=targetfun(xx);
end
Fitvalue=Fitvalue'+230;
fsum=sum(Fitvalue);
Pperpopulation=Fitvalue/fsum;
cumsump(1)=Pperpopulation(1);
for i =2:popsize
    cumsump(i)=cumsump(i-1)+Pperpopulation(i);
end
cumsump=cumsump';