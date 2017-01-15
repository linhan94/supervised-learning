%excercise 10c

clear;
load('boston.mat');
x = boston(:,1:13);
y = boston(:,14);

error_train = zeros(1,20);
error_validate = zeros(15,13,20);
error_test = zeros(1,20);
regularization_para = zeros(1,20);
for j = 1:1
    [trainInd,valInd,testInd] = dividerand(1:506,2/3,0,1/3);%split the dataset randomly
    x_train_final = x(trainInd,:); 
	x_test = x(testInd,:);
    y_train_final = y(trainInd,:);
	y_test = y(testInd,:);

    x_split = zeros(20,10,5); %Split the training set into mutiple sections
    y_split = zeros(20,1,5);
    for l = 1:5
        x_validate_split(:,:,l) = x_train_final(1+(l-1)*67:l*67,:);
        y_validate_split(:,:,l) = y_train_final(1+(l-1)*67:l*67,:);
        if (l==1)
        	x_train_split(:,:,l) = x_train_final(l*67+1:337,:);
            y_train_split(:,:,l) = y_train_final(l*67+1:337,:);
        elseif(l==5)
            x_train_split(:,:,l) = x_train_final(1:270,:);
            y_train_split(:,:,l) = y_train_final(1:270,:);    
        else
            x_train_split(:,:,l) = x_train_final([1:(l-1)*67,1+l*67:337],:);
            y_train_split(:,:,l) = y_train_final([1:(l-1)*67,1+l*67:337],:);
        end
    end
    minError = [10000,10000,10000,10000,10000];
    minParameter = [0,0,0,0,0];
    minVariant = [0,0,0,0,0];
    for l = 1:5
        x_train = x_train_split(:,:,l);
        y_train = y_train_split(:,:,l);
        x_validate = x_validate_split(:,:,l); 
        y_validate = y_validate_split(:,:,l);
        
        h=1;
        for o = 7:0.5:13
            k=1;
            for i = -40:1:-26
                for p = 1:length(x_train)
                    for q = 1:length(x_train)
                        k_train(p,q) = exp(-(norm(x_train(p,:)-x_train(q,:)))^2/(2*(2^o)^2));
                        %Gaussian kernel of training set
                    end
                end

                alpha = kridgereg(k_train,y_train,2^(i)*length(y_train));
                
                for p = 1:length(x_validate)
                    for q = 1:length(x_train)
                        k_validate(p,q) = exp(-(norm(x_validate(p,:)-x_train(q,:)))^2/(2*(2^o)^2));
                        %Gaussian kernel of training set
                    end
                end
                y_validate_train = k_validate*alpha; %generate new new validate y with alpha
                    
                %error_train(k,h,j) = dualcost(k_train,y_train,alpha); %MSE train
                error_validate(k,h,j) = dualcost(k_validate,y_validate,alpha); %MSE validate
                if (error_validate(k,h,j)<minError(l))
                    minError(l) = error_validate(k,h,j);
                    minParameter(l) = i;
                    minVariant(l) = o;
                end
                k=k+1;
            end
            h=h+1;
        end
        meanMinError = mean(minError);
        meanMinPara = mean(minParameter);
        meanMinVariant = mean(minVariant);
    end
       
    for p = 1:length(x_train_final)
        for q = 1:length(x_train_final)
            k_train_final(p,q) = exp(-(norm(x_train_final(p,:)-x_train_final(q,:)))^2/(2*(2^o)^2));
            %Gaussian kernel of training set
        end
    end
	for p = 1:length(x_test)
        for q = 1:length(x_train_final)
            k_test(p,q) = exp(-(norm(x_test(p,:)-x_train_final(q,:)))^2/(2*(2^o)^2));
            %Gaussian kernel of training set
        end
    end
    alpha = kridgereg(k_train_final,y_train_final,2^(meanMinPara)*length(y_train_final));
        
    y_test_train = k_test*alpha; %generate new new validate y with alpha
    
	error_train(j) = dualcost(k_train_final,y_train_final,alpha); %MSE train
    error_test(j) = dualcost(k_test,y_test,alpha); %MSE test
    
	regularization_para(j) = 2^(meanMinPara);
end

error_train_p = zeros(15,13);
error_validate_p = zeros(15,13);
for o = 1:13
	for i = 1:15
    %error_train_p(i,o) = mean(error_train(i,o,:));
    error_validate_p(i,o) = mean(error_validate(i,o,:));
    end
end

xyz = zeros(195,3);
j = 1;
l = 1;
for o = 7:0.5:13
    k = 1;
    for i = -40:1:-26
        xyz(j,:) = [i,o,error_validate_p(k,l)];
        j = j+1;
        k = k+1;
    end
    l = l+1;
end
%pcshow(xyz,'MarkerSize',300);
figure; scatter3(xyz(:,1),xyz(:,2),xyz(:,3), 'filled');
xlabel('log2 of regularization parameter')
ylabel('log2 of variance parameter')
zlabel('error')

mean_error_train = mean(error_train)
mean_error_test = mean(error_test)
std_error_train = std(error_train)
std_error_test = std(error_test)