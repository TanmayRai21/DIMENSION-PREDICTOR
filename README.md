# DIMENSION-PREDICTOR
A Digital Image Processing project performed on MATLAB to predict the largest dimension of any or all the objects in an Image.

# Prerequisites
MATLAB + Image Processing Toolbox

# Concepts
Image Segmentation : Image segmentation is a commonly used technique in digital image processing and analysis to partition an image into multiple parts or regions, often based on the characteristics of the pixels in the image. Image segmentation involves converting an image into a collection of regions of pixels that are represented by a mask or a labeled image. By dividing an image into segments, you can process only the important segments of the image instead of processing the entire image. 
A common technique is to look for abrupt discontinuities in pixel values, which typically indicate edges that define a region. 


Spatial Calibration

# FUNCTIONS USED

•	imread(filename) - Read image from graphics file
•	imshow(I) - Display image
•	im2bw(I,level) - Convert image to binary image, based on threshold
•	imfill(BW,locations) - Fill image regions and holes
•	imclose(Ifilled,se) - Morphologically close image
•	imopen(Iopenned,se) -  Morphologically open image
•	regionprops('table',Iopenned,'Centroid','MajorAxisLength','MinorAxisLength') - Measure properties of image regions
•	bwlabel(BW) - Label connected components in 2-D binary image
•	find(X) - Find indices and values of nonzero elements

# Note

The Threshold for (R, G, B) Matrices is 0.5, 0.5 and 0.5 for the images of the Toys_Candy, Pens, Baseball and the Phone Camera Image.

The threshold for (R, G, B) Matrices is 0.38, 0.35 and 0.38 for the images of the Toys image. This is because the overlapping shadows in the image cause the program to 

# SHORTCOMINGS AND FUTURE WORK

-	Bright spots and shadows in the image can cause errors in object detection. Therefore, Image Enhancement techniques have to be used enhance the image before performing the Image Segmentation
-	The threshold values do not work for all kinds of images. A algorithm has to be devised to make the threshold values adapt to the contents of the image.  

