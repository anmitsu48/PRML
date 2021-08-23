function error = ridge(M_train, lambda_train, x_train, y_train, x_valid, y_valid)
%%% PRML_chap_1_3_1.m で使用 %%%
%% Imput
% M_train：多項式の次数
% lambda_train：正則化パラメータ
% x_train：トレーニングデータの x 成分
% y_train：トレーニングデータの y 成分
% x_valid：検証用データの x 成分
% y_valid：検証用データの y 成分
%% Output
% error：検証用データに対するエラー

%% Training
N_train = size(x_train,2);
x_matrix = [ones(N_train,1), zeros(N_train,M_train)];

for i = 1:M_train
    x_matrix(:,i+1) = transpose(x_train).^(i);
end

w = (transpose(x_matrix) * x_matrix + lambda_train * eye(M_train+1)) ...
    \ (transpose(x_matrix) * transpose(y_train));

%% Validation (Calculate Error)
N_valid = size(x_valid,2);
X_matrix = [ones(N_valid,1), zeros(N_valid,M_train)];

for i = 1:M_train
    X_matrix(:,i+1) = transpose(x_valid).^(i);
end

y_estimate = X_matrix * w;

error = norm(y_estimate - transpose(y_valid))^2;
end