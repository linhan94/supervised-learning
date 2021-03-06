%This script shows excercise5 a)
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

    x_test = x(101:600,:); % Split the data set into a test set of size 500.
    y_test = y(101:600,:);
    x_split = zeros(20,10,5); %Split the training set into mutiple sections
    y_split = zeros(20,1,5);
    for l = 1:5
        x_validate_split(:,:,l) = x(1+(l-1)*20:l*20,:);
        y_validate_split(:,:,l) = y(1+(l-1)*20:l*20,:);
        if (l==1)
        	x_train_split(:,:,l) = x(l*20+1:100,:);
            y_train_split(:,:,l) = y(l*20+1:100,:);
        elseif(l==5)
            x_train_split(:,:,l) = x(1:80,:);
            y_train_split(:,:,l) = y(1:80,:);    
        else
            x_train_split(:,:,l) = x([1:(l-1)*20,1+l*20:100],:);
            y_train_split(:,:,l) = y([1:(l-1)*20,1+l*20:100],:);
        end
    end
    minError = [10000,10000,10000,10000,10000];
    minParameter = [0,0,0,0,0];
    for l = 1:5
        x_train = x_train_split(:,:,l);
        y_train = y_train_split(:,:,l);
        x_validate = x_validate_split(:,:,l); 
        y_validate = y_validate_split(:,:,l);
        
        k=1;
        
        for i = -6:1:3
            w_train = (x_train'*x_train + 10^(i)*100*eye(10)) \ x_train' * y_train; %perform ridge regression
            y_validate_train = x_validate*w_train; %generate new new noisy data set using estimated w

            %%Using equation (3) compute the mean squared error on the training set
            error_train(k,j) = 80 \ (w_train' * x_train' * x_train * w_train - 2 * y_train'...
                * x_train * w_train + y_train' * y_train); 

            %Using equation (3) compute the mean squared error on the test sets
            error_validate(k,j) = 20 \ (w_train' * x_validate' * x_validate * w_train - 2 * y_validate'...
                * x_validate * w_train + y_validate' * y_validate); 
            if (error_validate(k,j)<minError(l))
                minError(l) = error_validate(k,j);
                minParameter(l) = i;
            end
            k=k+1;
        end
        meanMinError = mean(minError);
        meanMinPara = mean(minParameter);
    end
        x_train_final = x(1:100,:); %training set for testing
        y_train_final = y(1:100,:);
        w_train_test = (x_train_final'*x_train_final + 10^(meanMinPara)*100*eye(10)) \ x_train_final' * y_train_final; %perform ridge regression
        y_test_train = x_test*w_train_test; %generate new new noisy data set using estimated w

        %%Using equation (3) compute the mean squared error on the training set
        error_train_test(j) = 100 \ (w_train_test' * x_train_final' * x_train_final * w_train_test - 2 * y_train_final'...
        * x_train_final * w_train_test + y_train_final' * y_train_final); 

        %Using equation (3) compute the mean squared error on the test sets
        error_test(j) = 500 \ (w_train_test' * x_test' * x_test * w_train_test - 2 * y_test'...
        * x_test * w_train_test + y_test' * y_test); 
        regularization_para(j) = 10^(meanMinPara);
end


error_train_p = zeros(10,1);
error_validate_p = zeros(10,1);
for i = 1:10
    error_train_p(i) = mean(error_train(i,:));
    error_validate_p(i) = mean(error_validate(i,:));
end
i = -6:1:3;
figure
plot(i,error_train_p);
title('mean training set errors with 80 samples')
xlabel('log(y)')
ylabel('errors')
figure
plot(i,error_validate_p);
title('mean validation set errors with 80 samples')
xlabel('log(y)')
ylabel('errors')
i = 1:200;
figure
plot(i,error_test);
title('testing errors with optimal regularization parameters')
xlabel('test times')
ylabel('errors')

'The average of regularization parameter is'
meanRegular = mean(regularization_para)