# Shape Detection of Liver From Ultra Sound Image

# step 1
download the whole repository with all assets.

# step 2
open the program in MATLAB (18 or later)

# step 3
shape_detection_of_liver_from_ultrasound_image.m is the main file. all the functions associate with this file are in the same folder. So only this file need to run.

# Overview 
This program is aim to detect shape of liver from ultra sound image. First it takes input image then enhance the image using sticks line where we use some heuristics to for ultrasound image. 

Then apply some morphological operations to remove outliers. 

After That the clean enhanced image get ready to extract the edge points of the liver from it. Then extract the edge points.

After that these edge points are used to fit the liver shape in the points using generalized hough transform algorithm.
