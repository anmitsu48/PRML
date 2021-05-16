%%%%% PRMLゼミ資料 %%%%%
% 1.1節関連
% 図1.2, 図1.4, 図1.6, 表1.1 関連

clear;
clc;
close all;

rng(11);

%% 人工データの生成
N = 100;
x = linspace(0,1,N);
t = sin(2*pi*x) + 0.3 * randn(1,N);

%% PRMLの図1.2の作成（人工データのプロット）
X = linspace(0,1,N*100);
figure(1);
hold on;
grid on;
scatter(x,t,'b','LineWidth',1);
plot(X,sin(2*pi*X),'g','LineWidth',1);
xlabel('x');
ylabel('t');
legend('データ点','真の曲線');
set(gca,'FontSize',16);
xlim([-0.02 1.02]);

%% 多項式曲線フィッティングの実装 ~ 重みの計算 ~ 
M = 9; 
x_matrix = [ones(N,1), zeros(N,M)];

for i = 1:M
    x_matrix(:,i+1) = transpose(x).^(i);
end

w = (transpose(x_matrix) * x_matrix) \ (transpose(x_matrix) * transpose(t));

%% 計算した重みを用いて予測して、プロット
X_matrix = [ones(N*100,1), zeros(N*100,M)];
for i = 1:M
    X_matrix(:,i+1) = transpose(X).^(i);
end

y = X_matrix * w;

figure(2);
hold on;
grid on;
scatter(x,t,'b','LineWidth',1);
plot(X,sin(2*pi*X),'g','LineWidth',1.5);
plot(X,y,'r','LineWidth',1.5);
%xlabel('x');
%ylabel('t');
title('M = ' + string(M) + ' の場合 （サンプル数：' + string(N) + '）');
legend('データ点','真の曲線','予測結果');
set(gca,'FontSize',16);
xlim([-0.02 1.02]);
ylim([-2 1.5]);