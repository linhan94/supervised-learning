clear;
datasize = 10000;
d = 2;
dataset = zeros(d,datasize);
for i=1:d
    for j=1:datasize
        dataset(i,j)= normrnd(0,1);
    end
end

z = [];
for i = 1:datasize
    temp = dataset(:,i)*dataset(:,i)';
    z = [z,temp(:)];
end

weightVector = normrnd(zeros(2,1),1);
weightVector1 = weightVector*weightVector';
