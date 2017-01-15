%This script shows excercise9
clear;

load('boston.mat');
x = boston(:,1:13);
y = boston(:,14);
error_train = zeros(20,13);
error_test = zeros(20,13);
for k = 1:13
    for j=1:20
        [trainInd,valInd,testInd] = dividerand(1:506,2/3,0,1/3);%split the dataset randomly
        x_train = [x(trainInd,k) ones(337,1)]; %the inputs are augmented with an additional 1 entry
        x_test = [x(testInd,k) ones(169,1)];
        y_train = y(trainInd,:);
        y_test = y(testInd,:);
        w = (x_train'*x_train) \ x_train' * y_train;
        %%Using equation (3) compute the mean squared error on the training set
        error_train(j,k) = 337 \ (w' * x_train' * x_train * w - 2 * y_train'...
            * x_train * w + y_train' * y_train); 

        %Using equation (3) compute the mean squared error on the test sets
        error_test(j,k) = 169 \ (w' * x_test' * x_test * w - 2 * y_test'...
            * x_test * w + y_test' * y_test); 
    end
end
for k = 1:13
    mean_error_train(k) = mean(error_train(:,k));
    mean_error_test(k) = mean(error_test(:,k));
    std_error_train(k) = std(error_train(:,k));
    std_error_test(k) = std(error_test(:,k));
end