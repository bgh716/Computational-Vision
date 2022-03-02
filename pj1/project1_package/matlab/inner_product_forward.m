function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1); % image size
k = size(input.data, 2); % batch size
n = size(param.w, 2); % prev layer dim (which is input img size in this case)
m = size(param.w, 1); % # of neurons

% Replace the following line with your implementation.
output.data = zeros([n, k]);
output.width = input.width;
output.height = input.height;
output.channel = input.channel;
output.batch_size = k;

for batch=1:k
    output.data(:,batch) = (param.w.')*input.data(:,batch) + param.b.';
end

end
