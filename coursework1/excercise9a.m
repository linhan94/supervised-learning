%This script shows excercise9a
clear;

load('boston.mat');
x = boston(:,1:13);
y = boston(:,14);
error_train = zeros(20,1);
error_test = zeros(20,1);
for j=1:20
    [trainInd,valInd,testInd] = dividerand(1:506,2/3,0,1/3);

    x_train = ones(337,13);
    x_test = ones(169,13);
    y_train = y(trainInd,:);
    y_test = y(testInd,:);

    b = zeros(13,1);
    for i=1:13
        b(i,1) = mean(y_train(i));
    end

    y_test_train = x_train*b;

    error_train(j) = 337 \ (b' * x_train' * x_train * b - 2 * y_train'...
        * x_train * b + y_train' * y_train); 
    error_test(j) = 169 \ (b' * x_test' * x_test * b - 2 * y_test'...
        * x_test * b + y_test' * y_test); 
end
mean_error_train = mean(error_train)
mean_error_test = mean(error_test)
std_error_train = std(error_train)
std_error_test = std(error_test)