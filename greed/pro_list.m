function list = pro_list(W)
list = [];
for i = 1:9
   str=machine_random(W,i);
   list = [list;str];
end
