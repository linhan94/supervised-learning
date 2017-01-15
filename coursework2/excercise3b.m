clear
minError= zeros(1,100);
error = zeros(1,100);
prevMinError = 1000;
for trial = 1:1:10
    for a = -2:0.5:2
        n = 500;
        d = 10;
        width = 5;
        sigma = 1;
        dataset = zeros(n,10);
        for i=1:d
            for j=1:n
                dataset(j,i)= normrnd(0,1);
            end
        end

        noiseTrain =zeros(62,1);
        for j=1:62
            noiseTrain(j,1)= normrnd(0,sigma);
        end
        noiseVali =zeros(62,1);
        for j=1:62
            noiseVali(j,1)= normrnd(0,sigma);
        end

        trainset = dataset(1:62,:);
        validateset = dataset(63:125,:);
        testset = dataset(126:500,:);
        Ktrain = zeros(62);
        for i=1:62
            for j = 1:62
                Ktrain(i,j) = exp(-(norm(trainset(i,:)-trainset(j,:)))^2 / 2 * width^2);
            end
        end

        KtrainP = zeros(62);
        for i=1:62
            for j = 1:62
                KtrainP(i,j) = exp(-(norm(trainset(i,:)-trainset(j,:)))^2 / 2 * (10^a) ...
                    * width^2);
            end
        end
        u = zeros(62,1);
        for i=1:1
            for j=1:62
                u(j,1)= normrnd(0,1);
            end
        end
        Ltrain = mychol(Ktrain,'upper');
        LtrainP = mychol(KtrainP,'upper');
        ytrueTrain = Ltrain * u + noiseTrain;

        Kvali = zeros(62);
        for i=1:62
            for j = 1:62
                Kvali(i,j) = exp(-(norm(validateset(i,:)-validateset(j,:)))^2 / 2 * width^2);
            end
        end
        KvaliP = zeros(62);
        for i=1:62
            for j = 1:62
                KvaliP(i,j) = exp(-(norm(validateset(i,:)-validateset(j,:)))^2 / 2 * (10^a)...
                    * width^2);
            end
        end
       
        Lvali = mychol(Kvali,'upper');
        LvaliP = mychol(KvaliP,'upper');
        alpha = (Ktrain + 1.3^2*eye(62))^(-1) * ytrueTrain;
        ypred = LvaliP * Ltrain' * alpha + noiseVali;
        ytrueVali = Lvali * u + noiseVali;
%         for o= 1:62
%             errorCo(o) = KvaliP(o,:) - exp(-(norm(trainset(o,:)-validateset(o,:)))^2 / 2 * (10^a)...
%                 * width^2) * inv((Ktrain)+sigma*eye(62)) * exp(-(norm(trainset(o,:)-validateset(o,:)))^2 / 2 * (10^a)...
%                 * width^2)';
%         end
        normError = ypred'-ytrueVali';
        [f,x] = ecdf(normError);
        error = (norm(f-normcdf(x)))^2;
        if error < prevMinError
            prevMinError = error;
            minWidth1 = width;
        end
    end
    minWidth(trial) = minWidth1;
    prevMinError = 1000;
    
end
meanWidth = mean(minWidth);
