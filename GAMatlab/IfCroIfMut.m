function pcc=IfCroIfMut(mut0Rcro)
test(1:100)=0;
l=round(100*mut0Rcro);
test(1:l)=l;
n=round(rand*99)+1;
pcc=test(n);