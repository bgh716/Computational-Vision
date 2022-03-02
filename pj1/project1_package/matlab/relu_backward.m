function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
input_od = zeros(size(input.data));

for batch=1:size(output.batch_size)
    input_od(:,batch) = output.diff(:,batch).*(input.data(:,batch)>0);
end
end