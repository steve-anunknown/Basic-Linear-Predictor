% This is a script that implements a basic linear predictor using a wiener
% filter. At first, an arma process is setup. Then, random data are
% generated and filtered according to that process so that they become
% correlated. Their autocorrelation function is then computed and used in
% order to calculate the coefficients of the wiener filter. Finally, the
% wiener filter is tested by computing a prediction and reviewing the error
% between it and the actual value.

% Setup an ar(1) process.
% You can modify it to setup any arma process and it should still work.
alpha = 0.8; 
numerator = [1-alpha^2 0];
denominator = [-alpha 1+alpha^2 -alpha];

% Generate random data, filter them according to the above process
% and calculate their autocorrelation.
data = filter(numerator, denominator, randn(1,100));
acf = autocorrelate(data);
MAX = length(data);

% random boundaries that define the input
FROM = 1;
DIFF = randi([1 MAX-1]);
TO = FROM+DIFF;
DEPTH = randi([1 MAX-TO]);  % random depth
[FROM DIFF TO DEPTH]    % optionaly print the indexes
wiener = wiener_filter(acf,FROM,TO,DEPTH) % wiener filter coefficients

% Test the predictor.
% Make sure that there are enough past samples
% to compute the prediction.
INDEX = length(wiener)+1; 
prediction = predict(wiener, data, INDEX)
actual_answer = data(INDEX+DEPTH)
error = abs(prediction-actual_answer)/abs(actual_answer)*100