function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    %output.data = zeros([h_out*w_out*c, batch_size]);
    %output.data = zeros([h_out,w_out,c, batch_size]);
    output.data = zeros([w_out,h_out,c, batch_size]);
    input_temp.data = input.data;
    ksq=k*k;
    for batch=1:batch_size
        input.data = input_temp.data(:,batch);
        partitions = im2col_conv_matlab(input, layer, h_out, w_out);
        for i=1:size(partitions)/(ksq*c)
            for j=1:c
                %output.data(w_out*h_out*(j-1)+h_out*(floor(i/h_out))+mod(i,h_out),batch) = max(partitions((c*i+j-1-c)*ksq+1:(c*i+j-c)*ksq));
                %output.data(mod(i-1,h_out)+1,floor((i-1)/h_out)+1,j,batch) = max(partitions((c*i+j-1-c)*ksq+1:(c*i+j-c)*ksq));
                output.data(mod(i-1,w_out)+1,floor((i-1)/w_out)+1,j,batch) = max(partitions((c*i+j-1-c)*ksq+1:(c*i+j-c)*ksq));
            end
        end
    end
    input.data = input_temp.data;
    output.data = reshape(output.data,h_out*w_out*c, batch_size);
end

