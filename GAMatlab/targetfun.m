%目标函数
function accept = targetfun(judge)
load 'time.mat'
load 'mj-con.mat'
load 'connection'
mat=zeros(36,8);
alist = zeros(9,4);
for i = 1:9
    sea_index = find(judge(1,:)==i);
    alist(i,:)=judge(2,sea_index);
end
bar = [4 3 3 3 4 4 4 4 2];
eqa = zeros(3,9);                %优先级顺序表
t = zeros(36,8);                   %时间安排表
seq = ones(1,9);        %工序步骤
%注意删除
%input_eqa2=2;
%eqa(2,input_eqa2)=1;%是否有需要提前交工
%注意删除
sheng = zeros(1,9);
for char = 1:9
var = eval(['t',int2str(char)]);
sheng(char) = (product(char)-1)*sum(var(2,:))+sum(var(1,:));
end                                  %剩余工时初始化
eqa(3,:)=sheng*4;
all_pro = sheng;


while(min(eqa(1,:))<300000)

%
index1=find(eqa(1,:)==min(eqa(1,:)));
[~,index3]=max(eqa(3,index1));

if(length(index1)~=1)
    if(any(eqa(2,:))&&length(find(eqa(2,:)~=0))==1&&eqa(1,input_eqa2)==min(eqa(1,:)))
        rechar=input_eqa2;
    else
        rechar=index1(index3);
    end
else
rechar=index1;    
end
%优先级比较方法,rechar为选择对象

machine = alist(rechar,seq(rechar));%所用机器
var = eval(['t',int2str(rechar)]);     %最优先零件加工矩阵
var_sp = var(:,seq(rechar));         %最优先情况加工矩阵（试切，加工）
list_time=find(t(:,machine)==0);
new_list = list_time(2);                %寻找到第二个为零的索引
pro=var_sp(1)+var_sp(2)*(product(rechar)-1);
t(new_list,machine)=eqa(1,rechar)+pro;%t表更新
no = find(mat(:,machine)==0);
suo = no(1);                           %寻找到第一个为零的索引
mat(suo,machine) = rechar;     %记录安排顺序
sheng(rechar)=sheng(rechar)-pro;   %更新剩余工时
seq(rechar)=seq(rechar)+1;             %更新工序
%
for j = 1:9
evar = eval(['t',int2str(j)]);
if seq(j)>4
eqa(1,j)=inf;                          %完成四步工序优先级变为inf
elseif seq(j)==1
will_use = alist(j,seq(j));           %即将使用的机床
eqa(1,j)=max(t(:,will_use));
elseif eqa(3,j)==0
eqa(1,j)=inf;
seq(j)=4;
else
used = alist(j,seq(j)-1);           %寻找到之前一次的使用机床
elist=find(mat(:,used)==j);      %找到该机床
eindex=elist(end)+1;                  %找到该机床最后一个元素
evar_sp = evar(:,seq(j)-1);       %之前工序的时间
will_use = alist(j,seq(j));           %即将使用的机床
show = evar_sp(1)+evar_sp(2)*(product(j)-1);    %工作时间
eqa(1,j)=max(max(max(t(:,will_use))),t(eindex,used)); %T1优先级更新完成
eqa(3,j)=all_pro(j)*(bar(j)-seq(j)+1)/show;                    %记得sheng要在更新后变化
end

end
end

accept=1/max(max(t));