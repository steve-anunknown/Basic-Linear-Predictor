function coefficients = wiener_filter(acf,from,to,depth)
    % Coefficients of wiener filter for prediction.
    % The function takes as input a WSS real-valued autocorrelation
    % function "acf", two pointers "from" and "to" that are the input's
    % bound and the desired prediciton depth.
    
    Ry = acf(from:to); % input of wiener filter
    Rdy = acf(from+depth:to+depth); % desired output 
    Ry = autocormatrix(Ry); % autocorrelation matrix of input
    coefficients = Ry\transpose(Rdy); % coefficients of wiener filter
end