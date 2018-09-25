function [number_nodes,number_ends]=count_node_end(main);
nodes=zeros(size(main));
branch_t=bwmorph(main,'thin',inf);
[m,n]=size(branch_t);
for l=2:n-1
for k=2:m-1
if branch_t(k,l)==1
d=find(branch_t(k-1:k+1,l-1:l+1));
if length(d)>3
nodes(k,l)=1;
end
end
end
end
nodes=logical(nodes);
[b,l]=bwlabel(nodes,8);
ss2=regionprops(b,'all');
number_nodes=length(ss2(:,1));
%%%%%%%%%%%%%%%%%%%%%%%
ends=zeros(size(main));

for l=2:n-1
for k=2:m-1
if branch_t(k,l)==1
d=find(branch_t(k-1:k+1,l-1:l+1));
if length(d)<=2                   %the ends with the island of one pixel
ends(k,l)=1;
end
end
end
end
ends=logical(ends);
[b1,l1]=bwlabel(ends,8);
s2=regionprops(b1,'all');
number_ends=length(s2(:,1));