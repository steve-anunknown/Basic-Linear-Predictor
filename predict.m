function prediction = predict(coeffs, data, index)
    % Returns the prediction of a future sample based on past data
    prediction = 0;
    limit = length(coeffs);
    for counter = 1:limit
        prediction = prediction + coeffs(counter)*data(index-counter+1);
    end
end