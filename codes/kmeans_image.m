%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna
function [Lb,cluster_metric,cts] = kmeans_image(I3,cts,iterations)
%get dimensions of image
[~,k] = size(cts);
[x,y,~] = size(I3);

%get three slices and as unsigned intger 16bit
R = int16(I3(:,:,1));
G = int16(I3(:,:,2));
B = int16(I3(:,:,3));

%initialise double matrices
dor = double(R);
dog = double(G);
dob = double(B);

%initialize temporary slices
dr = R;
dg = G;
db = B;
%initialise min distance matrix
minDist  = int16(255*ones(x,y));
minDist = minDist.^2; 

%Inialise Label matrix
Lb = int16(ones(x,y));

%implement kmeans

for j =1:iterations

%Assosciate points to each cluster.
for i=1:k
%Computing distance of ith cluster with all points together rather that one
%point with all clusters.
%Matrix operations are faster in Matlab
%subtract to get the sides of triangle to form distance.
dr = R - cts(1,i);
dg = G - cts(2,i);
db = B - cts(3,i);

D_mat = dr.^2 + dg.^2 + db.^2;  %get eucledian distance. Ignore sqaure root. by element wise squaring


minDist = min(minDist,D_mat);  %Find minimum with previous minimum distance matrix
%Final D_mat would be matrix with all minimum distances.

L = minDist == D_mat; %Get the logical array of elements similar to current cluster distance matrix
%So all values except that belonging to ith cluster would be zero. 


%Most important step.  
%MAke all points zero which do not belong to ith
%cluster + points belonging to ith cluster*i. This results in labelling the
%points
Lb = Lb.*int16(~L) + int16(L)*int16(i);  %updtae labels which are minimum. The labels slowly becomes final labels


end

%Next is update the cluster centres

%initialize temporary slices

for i=1:k
    
    %Make all points of cluster except that of i cluster 0 so that we can
    %take add only those points
    L = Lb == ones(x,y)*i;% A logical array which is 1 for point belonging to ith cluster and 0 for other cluster
    %Lz = int16(L);
    rr = dor.*L;
    gg = dog.*L;
    bb = dob.*L;
    
    %get centroid
    cr = sum(sum(rr))/nnz(rr);
    cg = sum(sum(gg))/nnz(gg);
    cb = sum(sum(bb))/nnz(bb);
    
    %Update the centroid
    cts(1,i) = cr;
    cts(2,i) = cg;
    cts(3,i) = cb;
    
  
end
end

%Now we need get the cluster metrics
cluster_metric = 0;
Io = double(I3);
cts1 = double(cts);
for i=1:k
    In = Io.*( Lb == ones(x,y)*i);
    In(:,:,1) =In(:,:,1)- cts1(1,i);
    In(:,:,2) =  In(:,:,2) -cts1(2,i);
    In(:,:,3) =  In(:,:,3)-cts1(3,i);
    %compute eu distance for all points
    In = In.^2;
    I_s = sum(In,3);
    I_s = I_s.^0.5;
    
    cluster_metric = cluster_metric + sum(sum(I_s));
    
   
end

cluster_metric = 1/cluster_metric;

end