clear;
n = 5000;
dataset = zeros(n,2);
for i=1:2
    for j=1:n
        dataset(j,i)= normrnd(0,1.5);
    end
end

width = 3;
Ktrue = zeros(n);
for i=1:n
    for j = 1:n
        Ktrue(i,j) = exp(-(norm(dataset(i,:)-dataset(j,:)))^2 / 2 * width^2);
    end
end

u = zeros(n,1);
for i=1:1
    for j=1:n
        u(j,1)= normrnd(0,1);
    end
end
L = mychol(Ktrue,'upper');
y = L * u;

scatter3(dataset(:,1),dataset(:,2),y, 'filled');
hold on;
xyz = [dataset real(y)];
pcshow(xyz,'MarkerSize',500);
