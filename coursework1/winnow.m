%Part 2 excercise 4 a, winnow

clear

%max_m = 50;
max_n = 100;
m = 1;

for n = 1:max_n
    %initial
    error_ratio = 1;
    
    T = 100*n;
    m=1;
    %perceptron
    while(error_ratio > 0.1)
        m = m + 1;
        error = 0;
        w = ones(n,1);
        rng('shuffle');
        x = sign(-0.5 + rand(m,n));
        for k = 1 : m
	        for l = 1 : n
                if(x(k,l) == -1)
                    x(k,l) = 0;
                end
            end
        end
	    y = x(:,1);
            
        for i = 1 : m
            y_train(i,:) = sign(x(i,:)*w);
            if(y_train(i,1) == -1)
                y_train(i,1) = 0;
            end
            if(y_train(i,:) ~= y(i,:))
                for k = 1:n
                    w(k,:) = w(k,:) * 2^((y(i)-y_train(i))*x(i,k));
                end
	        end
        end
        rng('shuffle');
        x = sign(-0.5 + rand(2000,n));
        y = x(:,1);
        for i = 1 : 2000
        	y_test(i,:) = sign(x(i,:)*w);
            if(y_test(i,:) ~= y(i,:))
                error = error + 1;
            end
        end
        error_ratio = error/2000;
    end
    m_plot(n) = m;
end

figure; plot(1:max_n, m_plot);
title('winnow')
xlabel('n')
ylabel('m')
