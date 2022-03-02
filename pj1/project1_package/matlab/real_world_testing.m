layers = get_lenet();
load lenet.mat

answer = zeros(1,5);
answer(1) = 0+1;
answer(2) = 1+1;
answer(3) = 5+1;
answer(4) = 7+1;
answer(5) = 9+1;

img_num = 5;

num0 = imread('../images/0.png');
num1 = imread('../images/1.png');
num5 = imread('../images/5.png');
num7 = imread('../images/7.png');
num9 = imread('../images/9.png');

num0 = imresize(num0,[28 28]);
num1 = imresize(num1,[28 28]);
num5 = imresize(num5,[28 28]);
num7 = imresize(num7,[28 28]);
num9 = imresize(num9,[28 28]);

num0 =rgb2gray(num0);
num1 =rgb2gray(num1);
num5 =rgb2gray(num5);
num7 =rgb2gray(num7);
num9 =rgb2gray(num9);

num0 = rescale(num0);
num1 = rescale(num1);
num5 = rescale(num5);
num7 = rescale(num7);
num9 = rescale(num9);

num0 = num0';
num1 = num1';
num5 = num5';
num7 = num7';
num9 = num9';

num0 = reshape(num0,28*28,1);
num1 = reshape(num1,28*28,1);
num5 = reshape(num5,28*28,1);
num7 = reshape(num7,28*28,1);
num9 = reshape(num9,28*28,1);

img = zeros(28*28,img_num);
img(:,1) = num0;
img(:,2) = num1;
img(:,3) = num5;
img(:,4) = num7;
img(:,5) = num9;
layers{1}.batch_size = img_num;

[output, P] = convnet_forward(params, layers, img);
[mx, index] = max(P);

cor = 0;
incor = 0;
for i=1:size(answer,2)
    if answer(i) == index(i)
        cor = cor + 1;
    else
        incor = incor + 1;
    end
end
fprintf('answer: ')
disp(answer)
fprintf('prediction: ')
disp(index)
fprintf('Accuracy: ')
disp(cor/(cor+incor));