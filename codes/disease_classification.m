%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna 


%Import the feature data
    data =csvread('C:/Users/ADMIN/Desktop/mtech/SEM2/DIP/code/final/Strawberry/gen_training.csv');

train_points = data(:,1:12);




train_labels = data(:,13);


data2 =csvread('C:/Users/ADMIN/Desktop/mtech/SEM2/DIP/code/final/Strawberry/gen_testing.csv');


test_points = data2(:,1:12);

test_labels = data2(:,13);


%normalise

%test_points = normc(test_points);
%train_points = normc(train_points);
%Normalise points
test_points = (test_points - min(test_points))./(max(test_points) - min(test_points));
train_points = (train_points - min(train_points))./(max(train_points)-min(train_points));

%KNN classification
[labels,accuracy] = KNN_classify(train_points,train_labels,test_points,test_labels,10);


%a = [test_labels labels label];

%SVM classification
sdl = fitcsvm(train_points,train_labels);
[label1,score] = predict(sdl,test_points);



count = 0;
[r,~] = size(test_labels);

for i=1:r
    if(label1(i) == test_labels(i))
        count = count +1;
    end
end
accuracy1 = count/r;

fprintf(' \n Accuracy of KNN is %f',accuracy);
fprintf('\n Accuracy of SVM is %f',accuracy1);

figure(1)
scatter(test_points(:,1),test_points(:,2),4,test_labels)
figure(2)
scatter(test_points(:,3),test_points(:,4),4,test_labels)
figure(3)
scatter(test_points(:,1),test_points(:,3),4,test_labels)
figure(4)
scatter3(test_points(:,5),test_points(:,8),test_points(:,4),8,test_labels)


