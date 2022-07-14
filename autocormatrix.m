function outmatrix = autocormatrix(inrow)
    % Creates the autocorrelation matrix of a real autocorrelation
    % function.
    % The autocormatrix function takes as input a row of numbers that
    % represents the values of a real WSS autocorrelation function and
    % constructs the corresponding autocorrelation matrix.
    
    outmatrix = zeros(length(inrow));
    for counter = 1:length(inrow)
        outmatrix(counter,counter:end) = inrow(1:end-counter+1);
        outmatrix(counter:end,counter) = inrow(1:end-counter+1)';
    end
end
