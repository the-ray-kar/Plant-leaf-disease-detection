%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna
%Data generator in csv





clc;
clear data;
directory = pwd;
%optional remove this after finishing
%directory = strcat(directory,'\sh');
names = {4};
names{1} = strcat(directory,'\Potato\training\Potato___healthy');
names{2}= strcat(directory,'\Potato\training\Potato___Early_blight');
names{3} = strcat(directory,'\Potato\testing\Potato___healthy');
names{4}= strcat(directory,'\Potato\testing\Potato___Early_blight');

data = {4};
%loop here
for i=1:4

D = names{i};
S = dir(fullfile(D,'*.JPG')); % pattern to match filenames.
index = int32(1);
n = numel(S);
x_data = zeros(n,13);
for k = 1:n
    tic
    F = fullfile(D,S(k).name);
    I = imread(F);
    %get features matrix
    features = getfeatures(I);
    if(i==1 || i==3)
    f = [features 1];
    else 
    f = [features 2];   
    %2 diseased 1 is healthy
    end
    
    x_data(index,:) = f;
    
    index = index+1;
    t = toc;
    time = t*(n-k)/3600+t*n*(4-i)/3600;
   fprintf('\n %f  perc Files Completed   %f out of 4 completed   %f hours left',k/n*100,i,time);
   
end
data{i} = x_data;
end

training_data = [data{1};data{2}];
testing_data = [data{3};data{4}];
training_data = training_data(randperm(size(training_data, 1)), :);
testing_data  = testing_data (randperm(size(testing_data , 1)), :);

csvwrite('testing.csv',testing_data);
csvwrite('training.csv',training_data);
