%GA主程序
clc,clear
data_save; %加载数据
accept=zeros(1,50);
Point=zeros(1,50);
P_c=0.4;  %交叉概率
P_m=0.1; %变异概率
gen=1;    %迭代次数
answer_min = 0;

for chr=1:50
eval(['save_random',int2str(chr),'=zeros(1,36);']);     %保留随机数据  第一子串
eval(['save_machine',int2str(chr),'=zeros(1,36);']);     %保留机器使用数据
eval(['judge_machine',int2str(chr),'=zeros(2,36);']);   %保留判断数据
for i = 1:36
    eval(['save_random',int2str(chr),'(i)','=randi([0,num_mac(i)-1]);']);
end
for i =1:36
    p = mac{i};
    h = eval(['save_random',int2str(chr),'(i)'])+1;
    eval(['save_machine',int2str(chr),'(i)','=p(h);']);
end
save_line = process();                                                     %保留第二子串编码
eval(['judge_machine',int2str(chr),'(1,:)','=save_line;']);         %第一行保留加工工序 judge_machine(1,:)第二子串
for i = 1:9
    index = find(save_line == i);
    cool=eval(['save_machine',int2str(chr),'(1,4*i-3:4*i)']);
    eval(['judge_machine',int2str(chr),'(2,index)','=cool;']); 
end

end

for mar = 1:50
    p = eval(['save_random',int2str(mar)]);
    q = eval(['judge_machine',int2str(mar),'(1,:)']);
    eval(['Ulist',int2str(mar),'=p;']);
    eval(['Vlist',int2str(mar),'=q;']);
end

while(gen<70)   %迭代次数可改变
for die = 1:50
accept(die)=targetfun(eval(['judge_machine',int2str(die)]));
if accept(die)> answer_min
    answer_min = accept(die);
    judge_machine = eval(['judge_machine',int2str(die)]);
end
end
aldie=sum(accept);
for str=1:50
Point(str)=accept(str)/aldie;
end                 %得到每个相对概率
Q=cumsum(Point); %轮盘概率
for kar = 1:50
eval(['Aex',int2str(kar),'=Ulist',int2str(kar)]);
eval(['Bex',int2str(kar),'=Vlist',int2str(kar)]);
end                      %交换序列
for dish=1:50 
    lun = rand(1,1);
    lun_index=find(lun<Q);
    lun_need = lun_index(1);
    eval(['Ulist',int2str(dish),'=Aex',int2str(lun_need)]);
    eval(['Vlist',int2str(dish),'=Bex',int2str(lun_need)]);
end
%新种群复制完成

num_first = floor(P_c*50);  %交叉条数
yan=randi(2,1,36)-1;
yan_in = find(yan==0);
make = round(rand(1,num_first)*49)+1;
for i = 1:10
father1=make(2*i-1);
father2=make(2*i);
for j = yan_in
father1_ex=eval(['Ulist',int2str(father1),'(j)']);
father2_ex=eval(['Ulist',int2str(father2),'(j)']);
eval(['Ulist',int2str(father1),'(j)','=father2_ex;']);
eval(['Ulist',int2str(father2),'(j)','=father1_ex;']);
end
end
%第一子串交叉方式

sui = randi(2,1,36)-1;
base = unidrnd(9);
make = round(rand(1,num_first)*49)+1;
for i = 1:10
all_ex1=1:36;
all_ex2=1:36;
father1=make(2*i-1);
father2=make(2*i);
Vlist_f1=eval(['Vlist',int2str(father1)]);
Vlist_f2=eval(['Vlist',int2str(father2)]);
base_index1=find(Vlist_f1==base);
base_index2=find(Vlist_f2==base);
all_ex1(base_index1)=[];
all_ex2(base_index2)=[];
for i = 1:32
eval(['Vlist',int2str(father1),'(all_ex1(i))','=Vlist_f2(all_ex2(i))']);
eval(['Vlist',int2str(father2),'(all_ex2(i))','=Vlist_f1(all_ex1(i))']);
end
end
%第二子串交叉方式


for count =1:50
for inner = 1:36
if rand(1,1)<P_m
    eval(['Ulist',int2str(count),'(inner)','=unidrnd(num_mac(inner))-1;']);
end
end
end
%第一子串
for count =1:50
for inner = 1:36
if rand(1,1)<P_m
    a =unidrnd(36);
    b =unidrnd(36);
    ta = eval(['Vlist',int2str(count),'(a)']);
    tb = eval(['Vlist',int2str(count),'(b)']);
    eval(['Vlist',int2str(count),'(a)','=tb;']);
    eval(['Vlist',int2str(count),'(b)','=ta;']);
end
end
end
%变异

for last = 1:50
    eval(['judge_machine',int2str(last),'(1,:)','=Vlist',int2str(last)]);
    for i =1:36
    p = mac{i};
    h=eval(['Ulist',int2str(last),'(i)'])+1;
    eval(['save_machine',int2str(last),'(i)','=p(h);']);
    end
    for j=1:9
        list_index=find(eval(['judge_machine',int2str(last),'(1,:)'])==j);
        lop = eval(['save_machine',int2str(last),'(4*j-3:4*j)']);
        eval(['judge_machine',int2str(last),'(2,list_index)','=lop']);
    end
end

%生成判断矩阵
gen=gen+1;
end
