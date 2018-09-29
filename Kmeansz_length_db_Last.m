figure(1);
I= imread('RA0101a.bmp');
imshow(I), title('RA0101a');
text(size(I,2),size(I,1)+15,...
     'Root Image, CMA', ...
     'FontSize',7,'HorizontalAlignment','right');

cform = makecform('srgb2xyz');
lab_I = applycform(I,cform);

figure (2); imshow(lab_I);
ab = double(lab_I(:,:,1:2));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nClusters = 2;
% repeat the clustering 3 times to avoid local minima
[cluster_idx cluster_center] = kmeans(ab,nClusters,'distance','sqEuclidean','Replicates',2);
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure (3);
imshow(pixel_labels,[]), title('image labeled by cluster index');
                                

figure (4);
bw=(pixel_labels)
imagesc (bw); figure(gcf)
SurfIr=bwarea(bw)
[m,n]=size(bw);
numberpixel=ones(7,1);
sizeblock=ones(7,1);
dimblock=ones(7,2);
for i=1:7
c=0;
d=0;
sizeblock(i,1)=ceil(m/(2^i))*ceil(n/(2^i));
dimblock(i,1)=ceil(m/(2^i));
dimblock(i,2)=ceil(n/(2^i));
c=blkproc(bw,[ceil(m/(2^i)),ceil(n/(2^i))],@sum);
d=blkproc(c,[1,ceil(n/(2^i))],@sum);
l=0;
m1=0;
n1=0;
[m1,n1]=size(d);
for k=1:m1
for j=1:n1
if d(k,j)~=0
l=l+1;
end
end
end
numberpixel(i,1)=l;
end
x=[ones(size(sizeblock)) log10(sqrt(sizeblock))];
b=regress(log10(numberpixel),x);
BIr(1,1)=b(1,1);
BIr(1,2)=b(2,1);

% Total length
% img=I(:,:,1);
% j=imadjust(img,stretchlim(img),[]);
% l=isodata(j);
% bw_l=im2bw(j,l);
% bw_l = imdilate(bw_l,strel('square',4));
% bw_l=bwareaopen(bw_l,300);

bw_l2=bwmorph(bw,'thin', inf);
figure (5);imshow(bw_l2)
bw_l1=bw_l2;
LengthsI=bwarea(bw_l2)
LengthaI=length(bw_l2(:,1));



