function y_estimate = ridge_estimate(M_best,lambda_best,x_train,y_train,x_estimate)
%%% PRML_chap_1_3_1.m で使用 %%%
%% Imput
% M_best：多項式の次数
% lambda_best：正則化パラメータ
% x_train：トレーニングデータの x 成分
% y_train：トレーニングデータの y 成分
% x_estimate：予測値を計算する x の値

%% Output
% y_estimate：学習した重みの下での予測値

%% Training
N_train = size(x_train,2);
x_matrix = [ones(N_train,1), zeros(N_train,M_best)];

for i = 1:M_best
    x_matrix(:,i+1) = transpose(x_train).^(i);
end

w = (transpose(x_matrix) * x_matrix + lambda_best * eye(M_best+1)) ...
    \ (transpose(x_matrix) * transpose(y_train));

%% Estimate
N_estimate = size(x_estimate,2);
X_matrix = [ones(N_estimate,1), zeros(N_estimate,M_best)];

for i = 1:M_best
    X_matrix(:,i+1) = transpose(x_estimate).^(i);
end

y_estimate = X_matrix * w;
end