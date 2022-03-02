layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
%imshow(img')
%disp(img)
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
imshow(output_1)
% Fill in your code here to plot the features.
global resultsdir
resultsdir = '../results';
[~,~,~] = mkdir(resultsdir);
fig = figure;

%disp(output{2});
%disp(output{3});

for n=2:3
    height=output{n}.height;
    width=output{n}.width;
    data_size=size(output{n}.data,1);
    channel =output{n}.channel;
    for i=1:data_size/(height*width)
        img = reshape(output{n}.data((i-1)*height*width+1:i*height*width,1),height,width);
        subplot(4,5,i), imshow(img)
    end
    sgtitle(layers{n}.type);
    filename = [resultsdir sprintf('/%s.png', layers{n}.type)];
    frame = getframe(fig);
    imwrite(frame2im(frame), filename);
end