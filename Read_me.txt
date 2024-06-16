Darekar Akshay Yuvraj
1911MT05  Mtech-Mechatronics

In order to see working code

Run plant_disease_feature_detection.m along with a leaf image in the same folder. 
This code only computes the features.
Provide the image name by editing imread command parameters



The automated function code for creating features of all images at once is csv_generate.m

1) The csv_generate grabs a image file.
2)Then calls getfeature function
3)The getfeature function calls genetic_alg, Kmean_image, and get_dis_image functions

genetic_alg is for genetic algorithm segmentation, kmeans is for kmeans segmentation and get_dis_image is for 
obtaining important segments.

4) Then the important segments is converted to hsv formats
5) Then each h, s and v matrix co-occurence matrix is computed using graycomatrix function
6)Finally features are computed using graycoprops function
7)Save the features in CSV file.

8) Each plant folder has four csv. Training and testing both with using Kmeans and Genetic Algorithm.



For classification disease_classification.m is the code.
1)It calls KNN(which is MDC) function and also calls SVM classifier internally.


The dataset used is from https://www.kaggle.com/vipoooool/new-plant-diseases-dataset
Dataset was large 1.33GB hence just put sample images in zip file for reference. 

There is sample segmented results.


Notes on feature extraction - It took 4hrs per leaf data to get all features of 1000 leaves
Hence I took only two types of plants Potato and Strawberry and two classes of each.



