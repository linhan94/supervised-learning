%function excercise2a
clear;
dataset = zeros(10000,2);
for i=1:2
    for j=1:10000
        dataset(j,i)= normrnd(0,1);
    end
end

K1 = [];
for i =1:10000
    temp = dataset(i,:)' * dataset(i,:);
    K1 = [K1;temp(:)'];
end
K2 = dataset' * (dataset * dataset') * dataset;
K3 = zeros(100,4);
for i=1:10000
K3(i,:) = [dot(dataset(i,1)', dataset(i,1)) dot(dataset(i,1)', dataset(i,2))...
    dot(dataset(i,2)', dataset(i,1)) dot(dataset(i,2)', dataset(i,2))];
end
weightVector = normrnd(zeros(2,1),1);
weightVector1 = weightVector'*weightVector;
weightVector2 = [dot(weightVector(1,1)', weightVector(1,1)); dot(weightVector(1,1)', weightVector(2,1));...
   dot(weightVector(2,1)', weightVector(1,1)); dot(weightVector(2,1)', weightVector(2,1))];
z = K1 * weightVector2;
%z = K3 * weightVector2;

scatter3(dataset(:,1),dataset(:,2),z, 'filled');
pcshow([dataset z],'MarkerSize',300);