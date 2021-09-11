%%% PRML 1.2節説明用 %%%
clear;
clc;
close all;

%% 標準正規分布の値の計算
x = -5:0.01:5;
mu = 0;
sigma = 2;
y = exp(-(x-mu).^2/(2*sigma)) / sqrt(2*pi * sigma^2);

%% プロット
figure(1);
hold on; grid on;
plot(x,y,'k','LineWidth',2);
area(x(1:451),y(1:451));
xline(0,'k','LineWidth',1);
xticks(-5:1:5);
set(gca,'FontSize',15);