%This script shows excercise1 a) and b)

x = rand(600,1); %xi are drawn from the standard normal distribution. 
w = rand(1,1); %Pick a random value for w ? ? from the standard normal distribution
n = rand(600,1); %ni are drawn from the standard normal distribution. 

y = x*w + n; %generate a noisy random data set, containing 600 samples

x_train = x(1:100); %Split the data set into a training set of size 100
y_train = y(1:100);
x_test = x(101:600); % Split the data set into a test set of size 500.
y_test = y(101:600);

w_train = (x_train'*x_train) \ x_train' * y_train; %Using equation (5), estimate w based on the training set
y_test_train = x_test*w_train; %generate new new noisy data set using estimated w

%%Using equation (3) compute the mean squared error on the training set
error_train = 100 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
    * x_train * w_train + y_train' * y_train); 

%Using equation (3) compute the mean squared error on the test sets
error_test = 500 \ (w_train' * x_test' * x_test * w_train - 2 * y_test'...
    * x_test * w_train + y_test' * y_test); 
