%function excercise1a
clear;
dataset = zeros(100,10);
for i=1:10
    for j=1:100
        dataset(j,i)= normrnd(0,1);
    end
end

trainingset = dataset(1:80,:);
testingset = dataset(81:100,:);

weightVector = normrnd(zeros(10,1),1);

noise = zeros(80,1);
for j=1:80
    noise(j,1)= normrnd(0,0.1);
end

observation = zeros(80,1);
for i=1:80
    observation(i,1) = dot(weightVector,trainingset(i,:)) + noise(i,1);
end

%Built in method
%trainingVector = ridge(observation, trainingset, 0.01);

%My method
trainingVector = inv(transpose(trainingset)*trainingset + 0.01*eye(10)) * transpose(trainingset) * observation;

Kt = trainingset * trainingset';
alpha = inv(Kt + 0.01*eye(80)) * observation;

noise = zeros(20,1);
for j=1:20
    noise(j,1)= normrnd(0,0.1);
end
trainingResult = zeros(20,1);
for i=1:20
    trainingResult(i,1) = dot(trainingVector,testingset(i,:)) + noise(i,1);
end
originalResult = zeros(20,1);
for i=1:20
    originalResult(i,1) = dot(weightVector,testingset(i,:)) + noise(i,1);
end

i=1:20;
trainingResult1 = testingset* trainingset' * alpha + noise;

i=1:20
originalResult1 = testingset * weightVector + noise;

error = (norm(originalResult-trainingResult))^2 / 20;
error1 = (norm(originalResult-trainingResult1))^2 / 20;

