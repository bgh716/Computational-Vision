%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix

Conf_mat = zeros(10,10);

for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [mx, index] = max(P);
    Conf_mat = Conf_mat + confusionmat(ytest(i:i+99),index);
end

% 8 and 3, 4 and 9
cor = 0;
incor = 0;
for i=1:10
    for j=1:10
        if i==j
            cor = cor + Conf_mat(i,j);
        else
            incor = incor + Conf_mat(i,j);
        end
    end
end
disp(Conf_mat);
disp(cor/(cor+incor));