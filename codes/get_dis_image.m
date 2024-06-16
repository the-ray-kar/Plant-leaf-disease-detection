%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna


function J = get_dis_image(Lb,I,k)
sum_mat = zeros(k,1);

[x,y,~] = size(I);
o = ones(x,y);

%get only green side of image 
I4 = (I(:,:,2));
%get grayscale
I7 = rgb2gray(I);
%create image to double
I8 = double(I7)/255; %total colour
I9 = double(I4)/255; %green side
%compute_ratio of green/total_pigment
I9 = rdivide(I9,I8);
I9 = I9/max(max(I9));  % I9 --> is actually the cos(Angle between total green and actual colour)

[~,IN] = max(I9(:));
[I_row, I_col] = ind2sub(size(I9),IN);
gi = Lb(I_row,I_col);

for i=1:k
    Lt = Lb==o.*i;
    sum_mat(i) = sum(sum(Lt));
    
   
end
    [~,idx] = sort(sum_mat);
    
    L1 = ~(Lb==o.*idx(k));
    if((k-1)==gi)
        L2 = ~(Lb==o.*idx(k-2));
    else
        L2 = ~(Lb==o.*idx(k-1));
    end
    %Remove the greener part also
    L3 = ~(Lb==o.*double(gi));
    
   
    
    L = L1&L2&L3;   
    L = uint8(L);
    J = I.*L;
    

    
    
end