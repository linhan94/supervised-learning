%function excercise1a
clear;
dataset = zeros(500,20);
for i=1:20
    for j=1:500
        dataset(j,i)= normrnd(0,1);
    end
end

trainingset = dataset(1:125,:);
testingset = dataset(126:500,:);

weightVector = normrnd(zeros(400,1),1);
z = [];
for i =1:125
    temp = trainingset(i,:)' * trainingset(i,:);
    z = [z;temp(:)'];
end

noise = zeros(125,1);
for j=1:125
    noise(j,1)= normrnd(0,5);
end

observation1= z * weightVector + noise;

%Kt = (trainingset * trainingset').^2;
Kt = z * z';
alpha = (Kt + 25*eye(125))^(-1) * observation1;

noise = zeros(375,1);
for j=1:375
    noise(j,1)= normrnd(0,5);
end

z1 = [];
for i =1:375
    temp = testingset(i,:)' * testingset(i,:);
    z1 = [z1;temp(:)'];
end
originalResult1 = z1 * weightVector + noise;
a = z' * alpha;
trainingResult1 = z1 * z' * alpha + noise;

error1 = (norm(originalResult1-trainingResult1))^2 / 375;

%c
sumError = 0;
sumLamda = 0;
prevMinError = 1000;
k = 1;
for j=1:100
    for i=1:20
        for j=1:500
            dataset(j,i)= normrnd(0,1);
        end
    end

    rng('shuffle');
    [trainInd,valInd,testInd] = dividerand(500,0.25,0.15,0.6);
    trainingset2 = dataset(trainInd,:);
    validateset2 = dataset(valInd,:);
    testingset2 = dataset(testInd,:);

    noise = zeros(125,1);
    for j=1:125
        noise(j,1)= normrnd(0,5);
    end
    noise2 = zeros(75,1);
    for j=1:75
        noise2(j,1)= normrnd(0,5);
    end
    noise3 = zeros(300,1);
    for j=1:75
        noise3(j,1)= normrnd(0,5);
    end

    z2 = [];
    for i =1:125
        temp = trainingset2(i,:)' * trainingset2(i,:);
        z2 = [z2;temp(:)'];
    end
    observation2 = z2 * weightVector + noise;

    z3 = [];
    for i =1:75
        temp = validateset2(i,:)' * validateset2(i,:);
        z3 = [z3;temp(:)'];
    end
    originalResult3 = z3 * weightVector;

    z4 = [];
    for i =1:300
        temp = testingset2(i,:)' * testingset2(i,:);
        z4 = [z4;temp(:)'];
    end
    originalResult4 = z4 * weightVector + noise3;

    error2 = zeros(1,33);

    for lamda= -4:0.25:4
        Kt = z2 * z2';
        alpha2 = (Kt + (10^lamda)*25*eye(125))^(-1) * observation2;
        trainingResult2 = z3* z2' * alpha2 + noise2;
        error2(1,k) = (norm(originalResult3-trainingResult2))^2/75;
        if(error2(1,k)<prevMinError)
            prevMinError = error2(1,k);
            alpha3 = alpha2;
            minLamda = lamda;
        end
        k = k+1;
    end
    validateResult2 = z4* z2' * alpha3 + noise3;
    minError = (norm(originalResult4-validateResult2))^2/300;
    sumError = sumError + minError;
    sumLamda = sumLamda + 10^minLamda*25;
    prevMinError = 1000;
    k = 1;
end
meanError = sumError/100;
meanLamda = sumLamda/100;

