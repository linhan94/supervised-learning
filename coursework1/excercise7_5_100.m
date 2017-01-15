%This script tune the regularization parameter ? with 100 samples
%by minimizing the validation error (based on a 80%/20% split) (exercise 5)
clear
error_train = zeros(10,200);
error_validate = zeros(10,200);
error_test = zeros(1,200);
regularization_para = zeros(1,200);
for j = 1:200
    x = rand(600,10); %xi are drawn from the standard normal distribution. 
    w = rand(10,1); %Pick a random value for w from the standard normal distribution
    n = rand(600,1); %ni are drawn from the standard normal distribution. 

    y = x*w + n; %generate a noisy random data set, containing 600 samples

    x_train = x(1:80,:); %Split the data set into a training set of size 80
    y_train = y(1:80,:);
    x_validate = x(81:100,:); %Split the data set into a validation set of size 20
    y_validate = y(81:100,:);
    x_test = x(101:600,:); % Split the data set into a test set of size 500.
    y_test = y(101:600,:);

    k=1;
    minError = 10000;
    for i = -6:1:3
        w_train = (x_train'*x_train + 10^(i)*100*eye(10)) \ x_train' * y_train; %perform ridge regression
        y_validate_train = x_validate*w_train; %generate new new noisy data set using estimated w

        %%Using equation (3) compute the mean squared error on the training set
        error_train(k,j) = 80 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
            * x_train * w_train + y_train' * y_train); 

        %Using equation (3) compute the mean squared error on the test sets
        error_validate(k,j) = 20 \ (w_train' * x_validate' * x_validate * w_train - 2 * y_validate'...
            * x_validate * w_train + y_validate' * y_validate); 
        if (error_validate(k,j)<minError)
            minError = error_validate(k,j);
            minParameter = i;
        end
        k=k+1;
    end
    x_train_final = x(1:100,:); %training set for testing
    y_train_final = y(1:100,:);
    w_train_test = (x_train_final'*x_train_final + 10^(minParameter)*100*eye(10)) \ x_train_final' * y_train_final; %perform ridge regression
    y_test_train = x_test*w_train_test; %generate new new noisy data set using estimated w

    %%Using equation (3) compute the mean squared error on the training set
    error_train_test(j) = 100 \ (w_train_test' * x_train_final' * x_train_final * w_train_test - 2 * y_train_final'...
	* x_train_final * w_train_test + y_train_final' * y_train_final); 

    %Using equation (3) compute the mean squared error on the test sets
    error_test(j) = 500 \ (w_train_test' * x_test' * x_test * w_train_test - 2 * y_test'...
    * x_test * w_train_test + y_test' * y_test); 
    regularization_para(j) = 10^(minParameter);
end

error_test_final = mean(error_test)
error_test_std = std(error_test)