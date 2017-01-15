%This script shows excercise1 d)
error_train1 = zeros(200,1);
error_test1 = zeros(200,1);
for i = 1:200
    x = rand(600,1); %xi are drawn from the standard normal distribution. 
    w = rand(1,1); %Pick a random value for w from the standard normal distribution
    n = rand(600,1); %ni are drawn from the standard normal distribution. 

    y = x*w + n; %generate a noisy random data set, containing 600 samples

    x_train = x(1:100); %Split the data set into a training set of size 100
    y_train = y(1:100);
    x_test = x(101:600); % Split the data set into a test set of size 500.
    y_test = y(101:600);

    w_train = (x_train'*x_train) \ x_train' * y_train; %Using equation (5), estimate w based on the training set
    y_test_train = w_train * x_test; %generate new new noisy data set using estimated w

    %%Using equation (3) compute the mean squared error on the training set
    error_train1(i) = 100 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
        * x_train * w_train + y_train' * y_train); 

    %Using equation (3) compute the mean squared error on the test sets
    error_test1(i) = 500 \ (w_train' * x_test' * x_test * w_train - 2 * y_test'...
        * x_test * w_train + y_test' * y_test); 
end

error_train2 = zeros(200,1);
error_test2 = zeros(200,1);
for i = 1:200
    x = rand(600,1); %xi are drawn from the standard normal distribution. 
    w = rand(1,1); %Pick a random value for w ? ? from the standard normal distribution
    n = rand(600,1); %ni are drawn from the standard normal distribution. 

    y = x*w + n; %generate a noisy random data set, containing 600 samples

    x_train = x(1:10); %Split the data set into a training set of size 10.
    y_train = y(1:10);
    x_test = x(101:600); % Split the data set into a test set of size 500.
    y_test = y(101:600);

    w_train = (x_train'*x_train) \ x_train' * y_train; %Using equation (5), estimate w based on the training set
    y_test_train = w_train * x_test; %generate new new noisy data set using estimated w

    %%Using equation (3) compute the mean squared error on the training set
    error_train2(i) = 10 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
        * x_train * w_train + y_train' * y_train); 

    %Using equation (3) compute the mean squared error on the test sets
    error_test2(i) = 500 \ (w_train' * x_test' * x_test * w_train - 2 * y_test'...
        * x_test * w_train + y_test' * y_test); 
end

compare = zeros(2,2);
compare(1,1) = mean(error_train1);
compare(1,2) = mean(error_test1);
compare(2,1) = mean(error_train2);
compare(2,2) = mean(error_test2);
