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

Kt = trainingset * trainingset';
alpha = (Kt + 0.01*eye(80))^(-1) * observation;
i = 1:80;
%trainingVector = sum(alpha(i,1)*dot(trainingset,trainingset(i,:)));


noise = zeros(20,1);
for j=1:20
    noise(j,1)= normrnd(0,0.1);
end

i=1:20;
trainingResult = alpha(i,1)*dot(testingset,testingset(i,:));

originalResult = zeros(20,1);
for i=1:20
    originalResult(i,1) = dot(weightVector,testingset(i,:)) + noise(i,1);
end

error = (sum(originalResult-trainingResult))^2 / 20;
