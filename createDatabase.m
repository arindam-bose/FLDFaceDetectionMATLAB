function [dataBase, row, col] = createDatabase(trainDatabasePath)
% Creates the training database which consists of 10 different faces of 40
% different persons making total of 400 faces.  
% 
% Argument:     trainDatabasePath      - Path of the training database
%
% Returns:      dataBase               - A 2D matrix, containing all 1D image vectors.
%                                        The length of 1D column vectors is MN and dataBase will be a MNxP 2D matrix.
%               row                    - number of rows (M) in a single image 
%               col                    - number of columns (N) in a single image
%
%% Gathering the names of all the image files and sort them
trainFiles = dir(trainDatabasePath);
isubFile = ~[trainFiles(:).isdir];
nameFiles = {trainFiles(isubFile).name};
num = zeros;
for i = 1:size(nameFiles,2)
    str = nameFiles(i);
    str  = sprintf(str{1}, '%s*');
    num(i)  = sscanf(str, '%d*');
end
[dummy, index] = sort(num);
nameFiles = nameFiles(index);

%% Construction of 2D matrix from 1D image vectors
dataBase = [];
for i = 1 : 180%size(nameFiles,2)
    fileName = nameFiles(i);
    filePath = fullfile(trainDatabasePath, fileName{1});
    img = imread(filePath);
    [row, col] = size(img);
    temp = reshape(img, row*col,1);
    dataBase = [dataBase temp];                  
end
dataBase = double(dataBase);
end