%%%%% PRMLゼミ資料 %%%%%
% 1.1節関連
% 図1.7 関連

clear;
clc;
close all;

rng(11);

%% 人工データの生成
N = 10;
x = linspace(0,1,N);
t = sin(2*pi*x) + 0.3 * randn(1,N);

%% 多項式曲線フィッティングの実装 ~ 重みの計算 ~ 
% w1 : 正則化なしの場合の重み
% w2 : 正則化ありの場合の重み
M = 9; 
lambda = exp(0);
x_matrix = [ones(N,1), zeros(N,M)];

for i = 1:M
    x_matrix(:,i+1) = transpose(x).^(i);
end

w1 = (transpose(x_matrix) * x_matrix) \ (transpose(x_matrix) * transpose(t));
w2 = (transpose(x_matrix) * x_matrix + lambda * eye(M+1)) \ (transpose(x_matrix) * transpose(t));

%% 計算した重みを用いて予測して、プロット
% w1 : 正則化なしの場合の推定結果
% w2 : 正則化ありの場合の推定結果
X = linspace(0,1,N*100);
X_matrix = [ones(N*100,1), zeros(N*100,M)];
for i = 1:M
    X_matrix(:,i+1) = transpose(X).^(i);
end

y1 = X_matrix * w1;
y2 = X_matrix * w2;

figure(1);
hold on;
grid on;
scatter(x,t,'b','LineWidth',1);
plot(X,sin(2*pi*X),'g','LineWidth',1.5);
plot(X,y1,'k--','LineWidth',1);
plot(X,y2,'r','LineWidth',1.5);
%xlabel('x');
%ylabel('t');
title('M = ' + string(M) + ' の場合 （ln \lambda = ' + string(log(lambda)) + '）');
legend('データ点','真の曲線','予測結果 (正則化なし)','予測結果 (正則化あり )',...
    'Location','SouthWest');
set(gca,'FontSize',16);
xlim([-0.02 1.02]);
ylim([-2 1.5]);