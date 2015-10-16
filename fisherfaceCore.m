function [meanDatabase, eigenFaces, V_Fisher, projectedImagesFisher] = fisherfaceCore(dataBase)
% Uses Principle Component Analysis (PCA) and Fisher Linear Discriminant (FLD) to determine the most 
% discriminating features between images of faces.
%
% Argument:      dataBase               - (MNxP) A 2D matrix, containing all 1D image vectors.
%                                         All of 1D column vectors have the same length of M*N 
%                                         and dataBase will be a MNxP 2D matrix.
% 
% Returns:       meanDatabase           - (MNx1) Mean of the training database
%                eigenFaces             - (M*Nx(P-C)) Eigen vectors of the covariance matrix of the training database
%                V_Fisher               - ((P-C)x(C-1)) Largest (C-1) eigen vectors of matrix J = inv(Sw) * Sb
%                projectedImagesFisher  - ((C-1)xP) Training images, which are projected onto Fisher linear space
%
%% Number of Classes and Class population
classPopulation = 9;
classCount = (size(dataBase,2))/classPopulation;
P = size(dataBase,2); 

%% Calculating the mean image 
meanDatabase = mean(dataBase,2); 

%% Calculating the deviation of each image from mean image
A = dataBase - repmat(meanDatabase, 1, P);

%% Calculating the eigenvectors, eigen values and taking the larger values
[eigenVectors, eigenValues] = eig(A'*A);
eigenVectors = eigenVectors(:, 1:P-classCount);

%% Calculating the eigenfaces
eigenFaces = A * eigenVectors;

%% Projecting centered image vectors onto eigenspace
projectedImagesPCA = [];
for i = 1 : P
    temp = eigenFaces'*A(:,i);
    projectedImagesPCA = [projectedImagesPCA temp]; 
end

%% Calculating the mean of each class in eigenspace
meanPCA = mean(projectedImagesPCA,2); 
m = zeros(P-classCount, classCount); 
Sw = zeros(P-classCount, P-classCount); 
Sb = zeros(P-classCount, P-classCount);

for i = 1 : classCount
    m(:,i) = mean(( projectedImagesPCA(:, ((i-1) * classPopulation+1) : i*classPopulation)), 2)';    
    
    S  = zeros(P-classCount, P-classCount); 
    for j = ((i-1)*classPopulation+1) : (i*classPopulation)
        S = S + (projectedImagesPCA(:,j) - m(:,i)) * (projectedImagesPCA(:,j) - m(:,i))';
    end
    
    Sw = Sw + S; 
    Sb = Sb + (m(:,i)-meanPCA) * (m(:,i)-meanPCA)';
end

%% Calculating Fisher discriminant basis
[J_eigenVector, J_eigenValue] = eig(Sb,Sw); % Cost function J = inv(Sw) * Sb
J_eigenVector = fliplr(J_eigenVector);

%% Eliminating zero eigens and sorting in descend order
V_Fisher = J_eigenVector(:, 1:classCount-1);

%% Projecting images onto Fisher linear space
projectedImagesFisher = zeros(classCount-1, P);
for i = 1 : classCount*classPopulation
    projectedImagesFisher(:,i) = V_Fisher' * projectedImagesPCA(:,i);
end
end