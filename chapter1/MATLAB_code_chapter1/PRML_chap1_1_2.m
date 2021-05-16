%%%%% PRMLゼミ資料 %%%%%
% 1.1節関連
% 図1.5 関連

clear;
clc;
close all;

rng(11);

%% 人工データの生成（訓練データ）
N = 10;
x = linspace(0,1,N);
t = sin(2*pi*x) + 0.3 * randn(1,N);

%% 多項式曲線フィッティングの実装 ~ 重みの計算 ~ 
M = 9; 
x_matrix = [ones(N,1), zeros(N,M)];

for i = 1:M
    x_matrix(:,i+1) = transpose(x).^(i);
end

w = (transpose(x_matrix) * x_matrix) \ (transpose(x_matrix) * transpose(t));
y = x_matrix * w;
error_training = sqrt(norm(y-transpose(t))^2 / N);

%% 計算した重みを用いて、RMSを計算
N_test = 100;
X = linspace(0,1,N_test);
test_y = transpose(sin(2*pi*X) + 0.3 * randn(1,N_test));

X_matrix = [ones(100,1), zeros(100,M)];
for i = 1:M
    X_matrix(:,i+1) = transpose(X).^(i);
end

y_test = X_matrix * w;

error_test = sqrt(norm(y_test-test_y)^2 / N_test);