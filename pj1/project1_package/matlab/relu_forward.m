function [output] = relu_forward(input)
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% Replace the following line with your implementation.
output.data = zeros(size(input.data));

for batch=1:input.batch_size
    for i=1:size(input.data)
        output.data(i,batch) = max(0,input.data(i,batch));
    end
end
end
