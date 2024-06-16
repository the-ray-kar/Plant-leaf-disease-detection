%Darekar Akshay Yuvraj
%1911MT05
%Mtech Mechatronics IITPatna


function Lb = genetic_alg(I,population,iterations,k)
%genetic_algorithm.



I = rgb2hsv(I);
%I(:,:,3) = I(:,:,2); %works well
%convert to normal I
I = uint8(255*I);
%Remove some background for dataset. Changes with backgrounf


[rows,columns,~] = size(I);



%encoding the clusters 

%no of clusters
% its k
%create an empty cell array
chromosome ={population};
cts = zeros(3,k);  %define cluster matrix

%mating population 
%should be even
mp = 4;

%population initialisation


for i=1:population
  
        x_vec = randi([1 rows],k,1);
        y_vec = randi([1 columns],k,1);
        for j=1:k
            cts(:,j) = I(x_vec(j),y_vec(j),:);
        end
        
    
    chromosome{i} = cts;
end

fitness = zeros(population,1);
for i=1:iterations
    %find fitness function
    for j=1:population
       
        [~,fitness(j),chromosome{j}] = kmeans_image(I,chromosome{j},1);
        
    end
    
    %Now we need to select best mp=4  chromosomes for mating.
    % So we use roulette wheel selection.
    
    %We normalise fitness  0 - 1
    
    %fitness = fitness./max(fitness);
    
    
    cf = cumsum(fitness);
    cf = cf./max(cf);
    
    %selected indices
    matepool = uint8(ones(mp,1));
    for j=1:mp
        number = rand(1);
        for t=1:population
            if(cf(t)>number)
                matepool(j) = t;
                break;
            end
        end
       
    end
    %Mater
    for j=1:2:mp
        %mate here 
        %get a random number
         p =randi([1 k],1);
         c1 = chromosome{matepool(j)};
         c2 = chromosome{matepool(j+1)};
         c3 =c2;
         %swap the centres
         c2(:,p:k) = c1(:,p:k);
         c1(:,p:k) = c3(:,p:k);
        
         %Mutate the first gene
         %randi([1 k],1)
         cm = (randi([1 10],3,k));
         c1= c1+cm;
         
         chromosome{matepool(j)} = c1;
         chromosome{matepool(j+1)} = c2;
         
        
   
    end
        
    
%    fprintf('% perc gen completed ',i/iterations*100);
    
    
end

[~,idx] = max(fitness);
[Lb,~,~] = kmeans_image(I,chromosome{idx},2);

end