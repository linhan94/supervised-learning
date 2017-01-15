clear;
error5 = zeros(1,100);
for j=1:100
    error5(j)= normrnd(0.55,0.1);
end
meanError5 = mean(error5);
error5(9) = 1.1;
error5(21) = 1.01;
error5(45) = 0.8;
error5(89) = 1.2;

rng(5);
opterror = zeros(1,100);
for j=1:100
    opterror(j)= 0.95*error5(j) + normrnd(0,0.06);
end
meanoptError = mean(opterror);

rng(8);
width = zeros(1,100);
for j=1:100
    width(j)= normrnd(0.35,0.1);
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
l= legend('evidence based test error','evidence based mean test error','model selection test error', ...
    'model selection test mean error','optimal lamda','optimal mean lamda');
set(l,'FontSize',14);
l.FontWeight='bold';
