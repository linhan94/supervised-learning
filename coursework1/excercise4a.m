%This script shows excercise3 a)

x = rand(600,10); %xi are drawn from the standard normal distribution. 
w = rand(10,1); %Pick a random value for w from the standard normal distribution
n = rand(600,1); %ni are drawn from the standard normal distribution. 

y = x*w + n; %generate a noisy random data set, containing 600 samples

x_train = x(1:100,:); %Split the data set into a training set of size 100
y_train = y(1:100,:);
x_test = x(101:600,:); % Split the data set into a test set of size 500.
y_test = y(101:600,:);

error_train = zeros(10,1);
error_test = zeros(10,1);
k=1;
for i = -6:1:3
    w_train = (x_train'*x_train + 10^(i)*100*eye(10)) \ x_train' * y_train; %perform ridge regression
    y_test_train = x_test*w_train; %generate new new noisy data set using estimated w

    %%Using equation (3) compute the mean squared error on the training set
    error_train(k) = 100 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
        * x_train * w_train + y_train' * y_train); 

    %Using equation (3) compute the mean squared error on the test sets
    error_test(k) = 500 \ (w_train' * x_test' * x_test * w_train - 2 * y_test'...
        * x_test * w_train + y_test' * y_test); 
    k=k+1;
end

i = -6:1:3;
figure
plot(i,error_train);
title('training set errors')
xlabel('log(y)')
ylabel('errors')
figure
plot(i,error_test);
title('testing set errors')
xlabel('log(y)')
ylabel('errors')