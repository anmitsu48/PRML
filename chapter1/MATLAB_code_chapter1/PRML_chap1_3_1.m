%%% PRML 1.3節説明用 %%%
clear;
clc;
close all;

rng(13);

%% Make Training Data
N_train = 15;
x_train = linspace(0,1,N_train);
y_train = sin(2*pi*x_train) + 0.3 * randn(1,N_train);

%% Make Validation Data
N_valid = 10;
x_valid = rand(1,N_valid);
y_valid = sin(2*pi*x_valid) + 0.3 * randn(1,N_valid);

%% Parameter %%
M = 1:1:8;
lambda = exp(-30:0.5:0);

%% Training
error_matrix = zeros(size(M,2), size(lambda,2));
error_min = inf;
error_min_index = [0 0];

for i = 1:size(M,2)
    for j = 1:size(lambda,2)
        M_train = M(i);
        lambda_train = lambda(j);
        error_matrix(i,j) = ridge(M_train, lambda_train, x_train, y_train, x_valid, y_valid);
        
        if error_matrix(i,j) < error_min
            error_min = error_matrix(i,j);
            error_min_index = [i j];
        end
    end
end

%% Plot Error
figure(1);
imagesc(log(lambda),M,error_matrix);
colormap jet;
axis tight;
title('Error Plot');
xlabel('log \lambda');
ylabel('M');
set(gca,'FontSize',16);

%% Plot Graph
x = 0:0.01:1;
y = sin(2*pi*x);

M_best = error_min_index(1);
lambda_best = lambda(error_min_index(2));
y_estimate = ridge_estimate(M_best,lambda_best,x_train,y_train,x);

figure(2);
hold on; grid on;
plot(x,y,'g--','LineWidth',1);
plot(x,y_estimate,'r','LineWidth',1);
scatter(x_train, y_train, 'bo','LineWidth',1.2);
scatter(x_valid, y_valid, 'kx','LineWidth',1);
yline(0,'k','LineWidth',0.5);
legend('真の曲線','学習結果','訓練用データ','検証用データ')
set(gca,'FontSize',16);
xticks(0:0.2:1);
yticks(-1.5:0.5:1.5);
xlim([-0.02 1.02]);
ylim([-1.6 1.6]);