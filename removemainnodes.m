# This script is a function to extract some of the features in a image 
function main=removemainnodes(s);

rgb=imread(s);
img=rgb(:,:,1);
img=imresize(img,0.5);
j=imadjust(img,stretchlim(img),[]);
l=isodata(j);
bw=im2bw(j,l);
b=bwareaopen(bw,200);
figure,imshow(b)


se=strel('disk',6);
a=imclose(imopen(b,se),se);
figure,imshow(a)
l=bwlabel(a,8);
z=regionprops(l,'all');
num_label=length(z);
a1=[];
a1(:,1)=[z.Area];
x=find(a1==max(a1));
ind=[z(x,1).PixelList];
big=bwselect(a,ind(1,1),ind(1,2));
figure,imshow(big)
main=logical(b-big);

main=bwareaopen(main,200);
figure,imshow(main)
