%This script shows excercise9
clear;

load('boston.mat');
x = boston(:,1:13);
y = boston(:,14);
error_train = zeros(20,1);
error_test = zeros(20,1);
for j=1:20
        [trainInd,valInd,testInd] = dividerand(1:506,2/3,0,1/3);%split the dataset randomly
        x_train = x(trainInd,:); 
        x_test = x(testInd,:);
        y_train = y(trainInd,:);
        y_test = y(testInd,:);
        w = (x_train'*x_train) \ x_train' * y_train;
        %%Using equation (3) compute the mean squared error on the training set
        error_train(j) = 337 \ (w' * x_train' * x_train * w - 2 * y_train'...
            * x_train * w + y_train' * y_train); 

        %Using equation (3) compute the mean squared error on the test sets
        error_test(j) = 169 \ (w' * x_test' * x_test * w - 2 * y_test'...
            * x_test * w + y_test' * y_test); 
end

mean_error_train = mean(error_train)
mean_error_test = mean(error_test)
std_error_train = std(error_train)
std_error_test = std(error_test)
