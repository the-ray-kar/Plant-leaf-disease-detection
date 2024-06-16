%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna

function [labels,accuracy] = KNN_classify(train_data,train_labels,testdata,test_labels,k)
%Get size of test data
[r,~] = size(testdata);


% Create a labels matrix
labels = int16(zeros(r,1));

for i=1:r
    %Take a point
    point = testdata(i,:);
    
    diff_point = train_data - point;
    
    diff_point = diff_point.^2;
    
    %Get the distance of each point of train data with test point
    dist_mat = sum(diff_point,2);
    %Sort based on ascending order
    [x,idx] = sort(dist_mat);
    
    %Get first k min values hence name of algorithm K-Nearest Neighbour
    %Get k points near the selected point
    min_values = x(1:k);
    min_indices = idx(1:k);
    
    %Get the respective labels
    l = zeros(k,1);
    for j=1:k
        l(j) = train_labels(min_indices(j));
    end
    
    %Assign the label which repeats the maximum
    labels(i) = mode(l);
    
    
    
    
    
    
end 

%compute accuracy
count = 0;
for i=1:r
    if(labels(i) == test_labels(i))
        count = count +1;
    end
end

accuracy = count/r;

end