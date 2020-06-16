clc
clear all
close all

%% Read in image
I = imread('Toys_Candy.jpg');
imshow(I);

%% Solution:  Thresholding the image on each color pane
Im=I;
rmat=Im(:,:,1);
gmat=Im(:,:,2);
bmat=Im(:,:,3);

subplot(2,2,1), imshow(rmat);
title('Red Plane');
subplot(2,2,2), imshow(gmat);
title('Green Plane');
subplot(2,2,3), imshow(bmat);
title('Blue Plane');
subplot(2,2,4), imshow(I);
title('Original Image');

%%
levelr = 0.5;
levelg = 0.5;
levelb = 0.5;
i1=im2bw(rmat,levelr);
i2=im2bw(gmat,levelg);
i3=im2bw(bmat,levelb);
Isum = (i1&i2&i3);

% Plot the data
subplot(2,2,1), imshow(i1);
title('Red Plane');
subplot(2,2,2), imshow(i2);
title('Green Plane');
subplot(2,2,3), imshow(i3);
title('Blue Plane');
subplot(2,2,4), imshow(Isum);
title('Sum of all the planes');

%% Complement Image or not
%Icomp = imcomplement(Isum);
Icomp = Isum;
flag=0;
Ifilled = imfill(Icomp,'holes');
%Remove blobs that are smaller than 7 pixels across
se = strel('disk',5);
Iopenned = imclose(Ifilled,se); %Closes the image with Structure Element Shape - Makes White
se = strel('disk',20);
Iopenned = imopen(Iopenned,se); %Opens the image with Structure Element Shape - Makes Black
stats = regionprops('table',Iopenned,'Centroid','MajorAxisLength','MinorAxisLength');

%% Fill in holes
while flag==0
Ifilled = imfill(Icomp,'holes');
%Remove blobs that are smaller than 7 pixels across
se = strel('disk',3);
Iopenned = imclose(Ifilled,se); %Closes the image with Structure Element Shape - Makes White
se = strel('disk',20);
Iopenned = imopen(Iopenned,se); %Opens the image with Structure Element Shape - Makes Black
stats = regionprops('table',Iopenned,'Centroid','MajorAxisLength','MinorAxisLength');
if stats.MajorAxisLength > ((length(I)+50))
    Icomp = imcomplement(Isum);
else
    flag=1;
end
end

%% Extract features
Objects = regionprops('table',Iopenned,'Centroid','MajorAxisLength','MinorAxisLength')

Iregion = regionprops(Iopenned, 'centroid');
[labeled,numObjects] = bwlabel(Iopenned,4);
stats = regionprops(labeled,'Eccentricity','Area','BoundingBox','MajorAxisLength');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

%% Use feature analysis to count skittles objects
idxOfSkittles = find(eccentricities);
statsDefects = stats(idxOfSkittles);

figure, imshow(Ifilled);
figure
imshow(Iopenned); title('Remove small blobs');
figure, imshow(I);
hold on;
for idx = 1 : length(idxOfSkittles)
        pos=statsDefects(idx).BoundingBox;
        h = rectangle('Position',pos,'LineWidth',2);
        set(h,'EdgeColor',[.75 0 0]);
        t= text(pos(1)+pos(3)/2,pos(2)+pos(4)/2,num2str(idx),'HorizontalAlignment','center');
        t.FontSize=16;
        t.Color=[.22 1 .08]; 
        t.FontWeight= 'bold';
        hold on;
end
title(['There are ', num2str(numObjects), ' objects in the image!']);
hold off;

%%Spatial Calibration
n=input('Enter the known objects index : ' );
d=input('Enter the known objects lenght in centimeters : ');
result(n)=d;

for i=1:length(idxOfSkittles)
    result(i)=(d*statsDefects(i).MajorAxisLength)/statsDefects(n).MajorAxisLength;
    fprintf("Major Axis Length of Object %d : %.3f cm\n",i,result(i));
end


