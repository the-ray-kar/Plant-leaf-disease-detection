%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna
function features = getfeatures(I)
[x,y,~] = size(I);
if(x*y>257*257)
    I = imresize(I,[256 NaN]);
end

%create a filter 
h = 1/9*[1 1 1;1 1 1;1 1 1];
I2=imfilter(I,h);

%Improve contrast by histogram equalisation but creates problem if contrasted image is segmented. Segment the actual Image
%loses information
%I = histeq(I2);

%Lb = genetic_alg(I,population=10,iterations=20,k=6);
k=6;
%This is for genetic algorithm
Lb = genetic_alg(I,15,15,k);
%This is for Kmeans just
%Lb = Kmeans_detect(I,k,30);

%
%Get important parts
J = get_dis_image(Lb,I,k);

%Get features
%Generate hue,sat,value
hsv = rgb2hsv(J);
hue = uint8(hsv(:,:,1)*255);
sat = uint8(hsv(:,:,2)*255);
value =uint8(hsv(:,:,3)*255);

%Generate features from final Image I

%Create co-occurence matrices
gl1 = graycomatrix(hue);
gl2 = graycomatrix(sat);
gl3 = graycomatrix(value);

%find properties of textures
stats1 =  graycoprops(gl1);
stats2 =  graycoprops(gl2);
stats3 =  graycoprops(gl3);

features = [stats1.Contrast stats1.Correlation stats1.Energy stats1.Homogeneity stats2.Contrast stats2.Correlation stats2.Energy stats2.Homogeneity stats3.Contrast stats3.Correlation stats3.Energy stats3.Homogeneity] ;


end