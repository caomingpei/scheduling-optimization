%Ŀ�꺯��
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
eqa = zeros(3,9);                %���ȼ�˳���
t = zeros(36,8);                   %ʱ�䰲�ű�
seq = ones(1,9);        %������
%ע��ɾ��
%input_eqa2=2;
%eqa(2,input_eqa2)=1;%�Ƿ�����Ҫ��ǰ����
%ע��ɾ��
sheng = zeros(1,9);
for char = 1:9
var = eval(['t',int2str(char)]);
sheng(char) = (product(char)-1)*sum(var(2,:))+sum(var(1,:));
end                                  %ʣ�๤ʱ��ʼ��
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
%���ȼ��ȽϷ���,recharΪѡ�����

machine = alist(rechar,seq(rechar));%���û���
var = eval(['t',int2str(rechar)]);     %����������ӹ�����
var_sp = var(:,seq(rechar));         %����������ӹ��������У��ӹ���
list_time=find(t(:,machine)==0);
new_list = list_time(2);                %Ѱ�ҵ��ڶ���Ϊ�������
pro=var_sp(1)+var_sp(2)*(product(rechar)-1);
t(new_list,machine)=eqa(1,rechar)+pro;%t�����
no = find(mat(:,machine)==0);
suo = no(1);                           %Ѱ�ҵ���һ��Ϊ�������
mat(suo,machine) = rechar;     %��¼����˳��
sheng(rechar)=sheng(rechar)-pro;   %����ʣ�๤ʱ
seq(rechar)=seq(rechar)+1;             %���¹���
%
for j = 1:9
evar = eval(['t',int2str(j)]);
if seq(j)>4
eqa(1,j)=inf;                          %����Ĳ��������ȼ���Ϊinf
elseif seq(j)==1
will_use = alist(j,seq(j));           %����ʹ�õĻ���
eqa(1,j)=max(t(:,will_use));
elseif eqa(3,j)==0
eqa(1,j)=inf;
seq(j)=4;
else
used = alist(j,seq(j)-1);           %Ѱ�ҵ�֮ǰһ�ε�ʹ�û���
elist=find(mat(:,used)==j);      %�ҵ��û���
eindex=elist(end)+1;                  %�ҵ��û������һ��Ԫ��
evar_sp = evar(:,seq(j)-1);       %֮ǰ�����ʱ��
will_use = alist(j,seq(j));           %����ʹ�õĻ���
show = evar_sp(1)+evar_sp(2)*(product(j)-1);    %����ʱ��
eqa(1,j)=max(max(max(t(:,will_use))),t(eindex,used)); %T1���ȼ��������
eqa(3,j)=all_pro(j)*(bar(j)-seq(j)+1)/show;                    %�ǵ�shengҪ�ڸ��º�仯
end

end
end

accept=1/max(max(t));