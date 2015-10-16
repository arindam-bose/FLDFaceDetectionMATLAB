% A FLD-based face recognition system (Fisherface method)
clear all;
clc;
close all;

%% Read Training and Test images path
% trainDatabasePath = uigetdir(pwd, 'Select Training Database Path');
% testDatabasePath = uigetdir(pwd, 'Select Test Database Path');
trainDatabasePath = 'TrainingFaces';
testDatabasePath = 'TestFaces';

dialogTitle = 'Input Test Image';
dialogPrompt = {'Enter Test Image Name (between 1 to 40):'};
defaultText = {'1'};

testImageName = {'6'};
% testImageName  = inputdlg(dialogPrompt, dialogTitle, 1, defaultText);
if str2double(testImageName{1}) >= 1 && str2double(testImageName{1}) <= 40
    testImageName = fullfile(testDatabasePath, [testImageName{1} '.pgm']);
    testImage = imread(testImageName);
else
    error('Input should be between 1 and 40');
end

%% Create database
[dataBase, r, c] = createDatabase(trainDatabasePath);

%% Determine the most discriminating features between images of faces.
[meanDatabase, eigenFaces, V_Fisher, projectedImagesFisher] = fisherfaceCore(dataBase);

%%
[distMin , index] = recognition(testImage, meanDatabase, eigenFaces, V_Fisher, projectedImagesFisher);

%% Print test image and equivalent recognized face from database
figure,
subplot(1,2,1), imshow(testImage);
title('Test Image');
subplot(1,2,2), imshow(uint8(reshape(dataBase(:,index), r, c)));
title('Equivalent Image from DataBase');

%% Print the minimum distance between the two images
disp(['Matched index is : ' num2str(index)]);
disp(['Minimum distance is : ' num2str(distMin)]);
