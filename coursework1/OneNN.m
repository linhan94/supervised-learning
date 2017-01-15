%Part 2 excercise 4 a, 1-NN

clear

%max_m = 50;
max_n = 10;
m = 1;

for j = 1:20
    for n = 1:max_n
        %initial
        %sample_complexity = 1;
        error_ratio = 1;
        T = 1*n;
        m = 1;
        %perceptron
        while(error_ratio > 0.1)
            m = m + 1;
            error = 0;

            w = zeros(n,1);
            rng('shuffle');
            x = sign(-0.5 + rand(m,n));
            y = x(:,1);

            x_table = x;
            y_table = y;

            rng('shuffle');
            x = sign(-0.5 + rand(2000,n));
            y = x(:,1);
            y_test = zeros(2000,1);

            for i = 1 : 2000
                minDistance = 1000;
                for j = 1:m
                    if (norm(x(i,:)-x_table(j,:)) < minDistance)
                        minDistance = norm(x(i,:)-x_table(j,:));
                        y_test(i,:) = y_table(j,:);
                    end
                end
                if(y_test(i,:) ~= y(i,:))
                    error = error + 1;
                end
            end
            error_ratio = error / 2000;
        end
        m_plot(n,j) = m;
    end
end

for i = 1:n
    mean_m_plot(i) = mean(m_plot(i,:));
end

figure; plot(1:max_n, m_plot);
title('1-NN')
xlabel('n')
ylabel('m')
