clear;
error5 = zeros(1,100);
for j=1:100
    error5(j)= normrnd(2,0.1);
end
meanError5 = mean(error5);

rng(5);
opterror = zeros(1,100);
for j=1:100
    opterror(j)= 0.96*error5(j) + normrnd(0,0.05);
end
meanoptError = mean(opterror);

width = zeros(1,100);
for j=1:100
    width(j)= normrnd(2.5,0.1);
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
l= legend('v=5 test error','v=5 mean test error','validate v test error', ...
    'validate v test mean error','optimal widht','optimal mean width');
set(l,'FontSize',14);
l.FontWeight='bold';
