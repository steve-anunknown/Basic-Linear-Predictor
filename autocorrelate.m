function autocorrelation = autocorrelate(data)
%   Returns values of the autocorrelation function of the input vector
    autocorrelation = conv(data,fliplr(data))/length(data);
end