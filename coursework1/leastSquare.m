%Part 2 excercise 4 a, least square

clear

%max_m = 50;
max_n = 100;
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

            w = pinv(x) * y;
            rng('shuffle');
            x = sign(-0.5 + rand(4000,n));
            y = x(:,1);
            for i = 1 : 4000
                y_test(i,:) = sign(x(i,:)*w);
                if(y_test(i,:) ~= y(i,:))
                    error = error + 1;
                end
            end
            %sample_complexity = 2^(-n) * error/m;
            error_ratio = error / 4000;
        end
        m_plot(n,j) = m;
    end
end

for i = 1:n
    mean_m_plot(i) = mean(m_plot(i,:));
end
    
figure; plot(1:max_n, mean_m_plot);
title('least square')
xlabel('n')
ylabel('m')
