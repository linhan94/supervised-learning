%Part 2 excercise 4 a, perceptron

clear

%max_m = 50;
max_n = 100;
m = 1;

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
        
        for i = 1 : m
            y_train(i,:) = sign(x(i,:)*w);
            if(y_train(i,:) ~= y(i,:))
                w = w + (y(i,:)*x(i,:))';
	        end
        end
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
    m_plot(n) = m;
end

figure; plot(1:max_n, m_plot);
title('perceptron')
xlabel('n')
ylabel('m')
