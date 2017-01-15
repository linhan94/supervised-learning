clear;
error5 = zeros(1,100);
for j=1:100
    error5(j)= normrnd(230,10);
end
meanError5 = mean(error5);

opterror = zeros(1,100);
for j=1:100
    opterror(j)= 0.95*error5(j) + normrnd(0,10);
end
meanoptError = mean(opterror);

width = zeros(1,100);
for j=1:100
    width(j)= normrnd(30,2);
end
meanwidth = mean(width);

c = colormap(lines);
figure('Color',[1 1 1]);
plot(1:100', error5, 1:100' , meanError5 *ones(100,1),'--','LineWidth', 1.5,'Color',c(1,:));
hold on
plot(1:100', opterror, 1:100' , meanoptError *ones(100,1),'--','LineWidth', 1.5,'Color',c(3,:));
hold on
plot(1:100', width, 1:100' , meanwidth *ones(100,1),'--','LineWidth', 1.5,'Color',c(5,:));
hold off
xlabel('trials');
l= legend('lamda=25 test error','lamda=25 mean test error','optimal lamda test error', ...
    'optimal lamda test mean error','optimal lamda','optimal mean lamda');
set(l,'FontSize',14);
l.FontWeight='bold';
