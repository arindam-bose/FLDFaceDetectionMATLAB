function [distMin , index] = recognition(testImage, meanDatabase, eigenFaces, V_Fisher, projectedImagesFisher)
% Compares two faces by projecting the images into facespace and measuring the Euclidean distance between them.
%
% Argument:      testImage              - Path of the input test image
%
%                meanDatabase           - (MNx1) Mean of the training database
%                eigenFaces             - (MNx(P-1)) Eigen vectors of the covariance matrix of 
%                                         the training database
%                V_Fisher               - ((P-1)x(C-1)) Largest (C-1) eigen vectors of matrix J = inv(Sw) * Sb
%                projectedImagesFisher  - ((C-1)xP) Training images, which are projected onto Fisher linear space
% 
% Returns:       distMin                - Minimum distance between the nearest image and the test image
%                index                  - index of the recognized image in the training database.
% 
%% Extracting the FLD features from test image
trainNumber = size(projectedImagesFisher,2);
[row, col] = size(testImage);
inputImage = reshape(testImage, row*col,1);
diffImage = double(inputImage) - meanDatabase;
projectedTestImage = V_Fisher' * eigenFaces' * diffImage; 

%% Calculating Euclidean distances
dist = [];
for i = 1 : trainNumber
    q = projectedImagesFisher(:,i);
    temp = ( norm( projectedTestImage - q ) )^2;
    dist = [dist temp];
end

[distMin , index] = min(dist);
end